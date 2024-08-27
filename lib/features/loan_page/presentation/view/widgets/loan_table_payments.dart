import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanPaymentTable extends StatelessWidget {
  final int monthNumber;
  final double loanAmountWithBenefit;
  final double monthlyOverallPayment;
  final double monthlyBenefitPayment;
  final double monthlyLoanPayment;

  final TransformationController _transformationController =
  TransformationController();

  LoanPaymentTable({super.key,
    required this.monthNumber,
    required this.monthlyOverallPayment,
    required this.monthlyBenefitPayment,
    required this.monthlyLoanPayment,
    required this.loanAmountWithBenefit});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.5,
      maxScale: 2.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dividerThickness: 0.1,
          columnSpacing: 20.0,
          headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFF004F9F)),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          rows: List<DataRow>.generate(
            monthNumber.toInt(),
                (index) =>
                DataRow(
                  color: MaterialStateColor.resolveWith((states) {
                    return index.isEven
                        ? Color(0xFFF5F8FF) // Even row color
                        : Colors.white; // Odd row color
                  }),
                  cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(Text(NumberFormat("#,##0").format(loanAmountWithBenefit -
                        (index * monthlyOverallPayment).round()))),
                    DataCell(Text(NumberFormat("#,##0").format(
                        monthlyOverallPayment.round()))),
                    DataCell(Text(
                        NumberFormat("#,##0").format(monthlyBenefitPayment.round()))),
                    DataCell(
                        Text(NumberFormat("#,##0").format(monthlyLoanPayment.round()))),
                    DataCell(
                      Text(NumberFormat("#,##0").format((loanAmountWithBenefit -
                          (index * monthlyOverallPayment))-monthlyOverallPayment.round() )),)
                  ],
                ),
          ),
          columns: const [
            DataColumn(label: Text('رقم الدفعة')),
            DataColumn(label: Text('مجموع الدفعات')),
            DataColumn(label: Text('الأساسي')),
            DataColumn(label: Text('الفائدة')),
            DataColumn(label: Text('الرصيد')),
            DataColumn(label: Text('المبلغ المتبقي')),
          ],
        ),
      ),);
  }
}
