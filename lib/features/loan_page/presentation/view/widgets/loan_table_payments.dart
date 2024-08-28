import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/util/screen_size.dart';

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
          columnSpacing: ScreenSizeUtil.screenWidth * 0.08,
          headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFF004F9F)),
          headingTextStyle:  TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSizeUtil.screenWidth*0.04
          ),
          rows: buildList(),
          columns: [
            DataColumn(label: Text('رقم الدفعة',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
            DataColumn(label: Text('مجموع الدفعات',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
            DataColumn(label: Text('الأساسي',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
            DataColumn(label: Text('الفائدة',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
            DataColumn(label: Text('الرصيد',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
            DataColumn(label: Text('المبلغ المتبقي',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
          ],
        ),
      ),);
  }

  List<DataRow> buildList() {
     return List<DataRow>.generate(
          monthNumber.toInt(),
              (index) {
                double remaining = loanAmountWithBenefit -
                    (index * monthlyOverallPayment)-monthlyOverallPayment.round() >0?  loanAmountWithBenefit -
                    (index * monthlyOverallPayment)-monthlyOverallPayment.round(): 0;
                return DataRow(
                color: MaterialStateColor.resolveWith((states) {
                  return index.isEven
                      ? const Color(0xFFF5F8FF) // Even row color
                      : Colors.white; // Odd row color
                }),
                cells: [
                  DataCell(Text('${index + 1}',style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
                  DataCell(Text(NumberFormat("#,##0").format(loanAmountWithBenefit -
                      (index * monthlyOverallPayment).round()),style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
                  DataCell(Text(NumberFormat("#,##0").format(
                      monthlyOverallPayment.round()),style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
                  DataCell(Text(
                      NumberFormat("#,##0").format(monthlyBenefitPayment.round()),style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
                  DataCell(
                      Text(NumberFormat("#,##0").format(monthlyLoanPayment.round()),style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),)),
                  DataCell( 
                    Text('${NumberFormat('#,##0').format(remaining)}' ,style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),),)
                ],
              );}
        );
  }
}
