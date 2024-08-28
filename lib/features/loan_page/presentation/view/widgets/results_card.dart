import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/util/screen_size.dart';
import '../../manger/loan_cubit.dart';

class ResultsCard extends StatelessWidget {
  const ResultsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        return Container(
          padding:  EdgeInsets.all(ScreenSizeUtil.screenWidth*0.05 ),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Colors.blue, Color(0xFF004F9F)]),
              borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          height: ScreenSizeUtil.screenHeight * 0.2,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الدفعات الشهرية',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:  ScreenSizeUtil.screenWidth*0.045,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    NumberFormat("#,##0").format(
                      context
                          .read<LoanCubit>()
                          .monthlyOverallPayment,
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:  ScreenSizeUtil.screenWidth*0.045,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مجموع الدفعات',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:  ScreenSizeUtil.screenWidth*0.045,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    NumberFormat("#,##0").format(context
                        .read<LoanCubit>()
                        .loanAmountWithBenefit
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeUtil.screenWidth*0.045,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

