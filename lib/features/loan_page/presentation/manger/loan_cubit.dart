import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(HomeInitial());
  TextEditingController benefitController = TextEditingController();
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController monthNumberController = TextEditingController();
  bool isButtonEnabled = false;

  int monthNumber() {
    if (monthNumberController.text.isEmpty) {
      return 0;
    }
    return int.parse(monthNumberController.text);
  }

  bool isTableShown = false;
  double monthlyOverallPayment = 0.0;
  double loanAmountWithBenefit = 0.0;

  double calcLoanMonthlyPayment() {
    double dLoanAmount = double.parse(loanAmountController.text);
    double dMonthNumber = double.parse(monthNumberController.text);
    return dLoanAmount / dMonthNumber.round();
  }

  void calcOverallMonthlyPayment() {
    double dBenefit = double.parse(benefitController.text);
    double dAmount = double.parse(loanAmountController.text);
    monthlyOverallPayment =
        (dAmount + (dAmount * dBenefit / 100)) / monthNumber().round();
    emit(GenerateResults());
  }

  void calcLoanAmountWithBenefit() {
    double dBenefit = double.parse(benefitController.text);
    double dAmount = double.parse(loanAmountController.text);
    loanAmountWithBenefit = dAmount + (dAmount * dBenefit / 100).round();
    emit(GenerateResults());
  }

  double calcMonthlyBenefitPayment() {
    double dBenefit = double.parse(benefitController.text);
    double dLoanAmount = double.parse(loanAmountController.text);
    double dMonthNumber = double.parse(monthNumberController.text);
    return dLoanAmount * (dBenefit / 100) / dMonthNumber.round();
  }

  bool isAmountValid = false;
  Icon amountIcon = const Icon(
    Icons.warning_amber_outlined,
    color: Colors.red,
  );

  void emitValidState() {
    emit(ValidAmount());
  }

  void checkLoanAmount() {
    if (double.parse(loanAmountController.text) >= 100000 &&
        double.parse(loanAmountController.text) <= 10000000) {
      isAmountValid = true;
      amountIcon = const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      );
      emit(ValidAmount());
    } else {
      isAmountValid = false;
      amountIcon = const Icon(
        Icons.warning_amber_outlined,
        color: Colors.red,
      );
      emit(InValidAmount());
    }
  }

  void calcResults(context) {
    if (loanAmountController.text.isNotEmpty &&
        monthNumber() > 0 &&
        benefitController.text.isNotEmpty) {
      if (double.parse(loanAmountController.text) >= 100000 &&
          double.parse(loanAmountController.text) <= 10000000) {
        calcOverallMonthlyPayment();
        calcLoanAmountWithBenefit();
        isButtonEnabled = true;
      } else {
        customSnackBar(context,
            'يجب أن يكون مبلغ القرض بين مئة الف وعشرة ملايين ليرة سورية');
      }
    } else {
      customSnackBar(context, 'جميع الحقول مطلوبة');
    }
  }

  void generateLoanTable() {
    isTableShown = true;
    emit(ShowLoanTable());
  }

  void resetAllValue() {
    loanAmountController.clear();
    loanAmountController.clear();
    monthNumberController.clear();
    benefitController.clear();
    monthlyOverallPayment = 0.0;
    loanAmountWithBenefit = 0.0;
    isButtonEnabled = false;
    isTableShown = false;
    emit(HideLoanTable());
  }

  void printTable(BuildContext context) async {
    final pdf = pw.Document();
    var fontdata = await rootBundle.load("assets/fonts/Almarai-Bold.ttf");
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                children: [
                  pw.Text(
                    "Loan Payment Table",
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 20),
                  pw.TableHelper.fromTextArray(
                    headers: [
                      'رقم الدفعة',
                      'مجموع الدفعات',
                      'الأساسي',
                      'الفائدة',
                      'الرصيد',
                      'المبلغ المتبقي'
                    ],
                    data: List<List<String>>.generate(
                      monthNumber(),
                      (index) {
                        final paymentNumber = (index + 1).toString();
                        final totalPayments = NumberFormat("#,##0").format(
                            loanAmountWithBenefit -
                                (index * monthlyOverallPayment).round());
                        final principal = NumberFormat("#,##0")
                            .format(monthlyOverallPayment.round());
                        final interest = NumberFormat("#,##0")
                            .format(calcMonthlyBenefitPayment().round());
                        final balance = NumberFormat("#,##0")
                            .format(calcLoanMonthlyPayment().round());
                        final remainingAmount = NumberFormat("#,##0").format(
                            (loanAmountWithBenefit -
                                    (index * monthlyOverallPayment)) -
                                monthlyOverallPayment.round());
                        return [
                          paymentNumber,
                          totalPayments,
                          principal,
                          interest,
                          balance,
                          remainingAmount
                        ];
                      },
                    ),
                    headerStyle: pw.TextStyle(
                        font: pw.Font.ttf(fontdata), color: PdfColors.white),
                    headerDecoration:
                        const pw.BoxDecoration(color: PdfColors.blue),
                    cellHeight: 30,
                    cellAlignments: {
                      0: pw.Alignment.centerRight,
                      1: pw.Alignment.centerRight,
                      2: pw.Alignment.centerRight,
                      3: pw.Alignment.centerRight,
                      4: pw.Alignment.centerRight,
                      5: pw.Alignment.centerRight,
                    },
                  ),
                ],
              ));
        },
      ),
    );

    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  void saveAsPdf(BuildContext context) async {
    final pdf = pw.Document();
    var fontdata = await rootBundle.load("assets/fonts/Almarai-Bold.ttf");
    // Create the PDF content
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                children: [
                  pw.Text(
                    "Loan Payment Table",
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 20),
                  pw.TableHelper.fromTextArray(
                    headers: [
                      'رقم الدفعة',
                      'مجموع الدفعات',
                      'الأساسي',
                      'الفائدة',
                      'الرصيد',
                      'المبلغ المتبقي'
                    ],
                    data: List<List<String>>.generate(
                      monthNumber(),
                      (index) {
                        final paymentNumber = (index + 1).toString();
                        final totalPayments = NumberFormat("#,##0").format(
                            loanAmountWithBenefit -
                                (index * monthlyOverallPayment).round());
                        final principal = NumberFormat("#,##0")
                            .format(monthlyOverallPayment.round());
                        final interest = NumberFormat("#,##0")
                            .format(calcMonthlyBenefitPayment().round());
                        final balance = NumberFormat("#,##0")
                            .format(calcLoanMonthlyPayment().round());
                        final remainingAmount = NumberFormat("#,##0").format(
                            (loanAmountWithBenefit -
                                    (index * monthlyOverallPayment)) -
                                monthlyOverallPayment.round());
                        return [
                          paymentNumber,
                          totalPayments,
                          principal,
                          interest,
                          balance,
                          remainingAmount
                        ];
                      },
                    ),
                    headerStyle: pw.TextStyle(
                        font: pw.Font.ttf(fontdata), color: PdfColors.white),
                    headerDecoration:
                        const pw.BoxDecoration(color: PdfColors.blue),
                    cellHeight: 30,
                    cellAlignments: {
                      0: pw.Alignment.centerRight,
                      1: pw.Alignment.centerRight,
                      2: pw.Alignment.centerRight,
                      3: pw.Alignment.centerRight,
                      4: pw.Alignment.centerRight,
                      5: pw.Alignment.centerRight,
                    },
                  ),
                ],
              ));
        },
      ),
    );

    if (await Permission.storage.request().isGranted) {
      String? downloadPath = await FilePicker.platform.getDirectoryPath();
      if (downloadPath != null) {
        final file = File(
            "$downloadPath/LoanPaymentTable_${DateTime.now().toIso8601String()}.pdf");
        await file.writeAsBytes(await pdf.save());
        // Notify the user of the successful save
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF saved to ${file.path}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not access the Downloads directory.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied. Cannot save PDF.')),
      );
    }
  }

  void saveAsXls(BuildContext context) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    List<CellValue> headers = [
      TextCellValue('رقم الدفعة'),
      TextCellValue('مجموع الدفعات'),
      TextCellValue('الأساسي'),
      TextCellValue('الفائدة'),
      TextCellValue('الرصيد'),
      TextCellValue('المبلغ المتبقي')
    ];

    sheetObject.insertRowIterables(headers.cast<CellValue?>(), 0);

    for (var i = 0; i < double.parse(monthNumberController.text); i++) {
      sheetObject.insertRowIterables([
        TextCellValue('0${i + 1}'),
        TextCellValue(NumberFormat("#,##0").format(
            loanAmountWithBenefit - (i * monthlyOverallPayment).round())),
        TextCellValue(
            NumberFormat("#,##0").format(monthlyOverallPayment.round())),
        TextCellValue(
            NumberFormat("#,##0").format(calcMonthlyBenefitPayment().round())),
        TextCellValue(
            NumberFormat("#,##0").format(calcLoanMonthlyPayment().round())),
        TextCellValue(NumberFormat("#,##0").format(
            (loanAmountWithBenefit - (i * monthlyOverallPayment)) -
                monthlyOverallPayment.round()))
      ], i + 1);
    }
    if (await Permission.storage.request().isGranted) {
      String? downloadPath = await FilePicker.platform.getDirectoryPath();
      if (downloadPath != null) {
        final file = File(
            "$downloadPath/loan_payment_table ${DateTime.now().toIso8601String()}.xlsx");
        await file.writeAsBytes(excel.encode()!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('XLS saved to ${file.path}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not access the Downloads directory.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied. Cannot save XLS.')),
      );
    }
  }
}
