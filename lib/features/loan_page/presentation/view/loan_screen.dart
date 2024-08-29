import 'package:bank_loan/features/clients_page/presentation/view/widgets/loan/client_loan_details.dart';
import 'package:bank_loan/features/loan_page/presentation/view/widgets/custom_circled_button.dart';
import 'package:bank_loan/features/loan_page/presentation/view/widgets/custom_text_field.dart';
import 'package:bank_loan/features/loan_page/presentation/view/widgets/custom_drop_down.dart';
import 'package:bank_loan/features/loan_page/presentation/view/widgets/loan_payments_table/loan_payments_table.dart';
import 'package:bank_loan/features/loan_page/presentation/view/widgets/results_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/screen_size.dart';
import '../manger/loan_cubit.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
  builder: (context, state) {
    var cubit = context.read<LoanCubit>();
    return CustomScrollView(slivers: [
      SliverAppBar(
          backgroundColor: Color(0xFFF7F7F7),
          floating: true,
          title: Text(
            'التقسيط',
            style: TextStyle(
              fontSize: ScreenSizeUtil.screenWidth*0.056
            ),
          )),
      SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: customTextField(
                    hintText: 'مبلغ القرض' ,
                    isBenefit: false,
                    onChanged: (val){
                      if(val.length>1){cubit.checkLoanAmount();}
                      else {
                        cubit.emitValidState();
                      }
                    },
                    icon: cubit.amountIcon,
                    context,
                    controller:
                    context.read<LoanCubit>().loanAmountController,
                    label: 'مبلغ القرض',
                  ),
                ),
                Column(
                  children: [
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "عدد الدفعات (أشهر)",
                        style: TextStyle(fontSize: ScreenSizeUtil.screenWidth*0.050),
                      ),
                    ),
                    CustomDropDown(cubit: cubit),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: customTextField(
                    hintText: 'نسبة الفائدة (%)',
                    isBenefit: true,
                    context,
                    controller:
                    context.read<LoanCubit>().benefitController,
                    label: 'نسبة الفائدة (%)',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSizeUtil.screenHeight * 0.03,
                      left: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0))),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                          const Color(0xFF004F9F),
                        )),
                    onPressed: () {
                      cubit.calcResults(context);
                    },
                    child:  Text(
                      'حساب الدفعات',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeUtil.screenWidth*0.035,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all( ScreenSizeUtil.screenWidth*0.03),
              child: ResultsCard(),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenSizeUtil.screenWidth*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCircularButton(
                    label: 'توليد جدول الدفعات',
                    onPressed: cubit.isButtonEnabled
                        ? () {
                      cubit.generateLoanTable();
                    }
                        : null,
                  ),
                  SizedBox(
                    width: ScreenSizeUtil.screenWidth * 0.1,
                  ),
                  CustomCircularButton(
                      onPressed: () {
                        cubit.resetAllValue();
                      },
                      label: 'إعادة ضبط'),
                ],
              ),
            ),
            if (context.read<LoanCubit>().isTableShown)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TableButtonsRow(),
                    Column(
                      children: [
                        LoanPaymentTable(
                          cubit: cubit,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ]);
  },
);
  }
}
