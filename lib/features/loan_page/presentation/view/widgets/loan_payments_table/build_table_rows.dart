import 'package:bank_loan/features/loan_page/presentation/manger/loan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/util/screen_size.dart';

List<DataRow> buildTableRows(LoanCubit cubit) {
  return List<DataRow>.generate(cubit.monthNumber().toInt(), (index) {
    double remaining = cubit.loanAmountWithBenefit -
                (index * cubit.monthlyOverallPayment) -
                cubit.monthlyOverallPayment.round() >
            0
        ? cubit.loanAmountWithBenefit -
            (index * cubit.monthlyOverallPayment) -
            cubit.monthlyOverallPayment.round()
        : 0;
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return index.isEven
            ? const Color(0xFFF5F8FF) // Even row color
            : Colors.white; // Odd row color
      }),
      cells: [
        DataCell(Text(
          '${index + 1}',
          style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
        )),
        DataCell(Text(
          NumberFormat("#,##0").format(cubit.loanAmountWithBenefit -
              (index * cubit.monthlyOverallPayment).round()),
          style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
        )),
        DataCell(Text(
          NumberFormat("#,##0").format(cubit.monthlyOverallPayment.round()),
          style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
        )),
        DataCell(Text(
          NumberFormat("#,##0")
              .format(cubit.calcMonthlyBenefitPayment().round()),
          style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
        )),
        DataCell(Text(
          NumberFormat("#,##0").format(cubit.calcLoanMonthlyPayment().round()),
          style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
        )),
        DataCell(
          Text(
            '${NumberFormat('#,##0').format(remaining)}',
            style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
          ),
        )
      ],
    );
  });
}
