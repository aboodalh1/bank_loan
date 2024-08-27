import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(HomeInitial());
  TextEditingController benefitController = TextEditingController();
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController monthNumberController = TextEditingController();
  bool isButtonEnabled = false;
  int monthNumber() {
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
    double dBenefit = double.parse(loanAmountController.text);
    double dAmount = double.parse(loanAmountController.text);
    loanAmountWithBenefit = dAmount + (dAmount * dBenefit / 100);
    emit(GenerateResults());
  }

  double calcMonthlyBenefitPayment() {
    double dBenefit = double.parse(benefitController.text);
    double dLoanAmount = double.parse(loanAmountController.text);
    double dMonthNumber = double.parse(monthNumberController.text);
    return dLoanAmount * (dBenefit / 100) / dMonthNumber.round();
  }
  bool isAmountValid = false;
  Icon amountIcon = const Icon(Icons.warning_amber_outlined,color: Colors.red,);
  void emitValidState(){
    emit(ValidAmount());
  }
  void checkLoanAmount() {

    if(double.parse(loanAmountController.text) >= 100000&&
        double.parse(loanAmountController.text)<10000000)
    {
    isAmountValid = true;
    amountIcon = const Icon(Icons.check_circle_outline,color: Colors.green,);
    emit(ValidAmount());
  }
  else {
    isAmountValid = false;
    amountIcon = const Icon(Icons.warning_amber_outlined);
    emit(InValidAmount());
    }

  }
  void calcResults(context) {
    if ( loanAmountController.text.isNotEmpty &&
        monthNumber() > 0 &&
        benefitController.text.isNotEmpty ) {
      calcOverallMonthlyPayment();
      calcLoanAmountWithBenefit();
      isButtonEnabled = true;
    }
    else {
      customSnackBar(context, 'جميع الحقول مطلوبة');

    }}

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

    void printTable(BuildContext context) {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text("Loan Payment Table"),
            );
          },
        ),
      );

      Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    }

    void saveAsPdf(BuildContext context) async {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text("Loan Payment Table"),
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/loan_payment_table.pdf");
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
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

      // Insert data rows (replace with actual data from your table)
      for (var i = 0; i < double.parse(monthNumberController.text); i++) {
        sheetObject.insertRowIterables([
          TextCellValue('0${i + 1}'),
          TextCellValue('80,000.00'),
          TextCellValue('7,410.76'),
          TextCellValue('1,333.33'),
          TextCellValue('6,077.43'),
          TextCellValue('73,922.57')
        ], i + 1);
      }

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/loan_payment_table.xlsx");
      await file.writeAsBytes(excel.encode()!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('XLS saved to ${file.path}')),
      );
    }
  }
