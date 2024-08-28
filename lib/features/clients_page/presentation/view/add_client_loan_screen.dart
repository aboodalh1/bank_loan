import 'package:bank_loan/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/client_loan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/screen_size.dart';
import '../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../loan_page/presentation/view/widgets/custom_circled_button.dart';
import '../../../loan_page/presentation/view/widgets/custom_text_field.dart';
import '../../../loan_page/presentation/view/widgets/custom_drop_down.dart';
import '../../../loan_page/presentation/view/widgets/loan_table_payments.dart';
import 'package:intl/intl.dart' as intl;
import '../../../loan_page/presentation/view/widgets/results_card.dart';

class AddClientLoanScreen extends StatelessWidget {
  const AddClientLoanScreen({super.key, required this.id});

  final num id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        var cubit = context.read<LoanCubit>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: CustomScrollView(slivers: [
              const SliverAppBar(
                  backgroundColor: Color(0xFFF7F7F7),
                  floating: true,
                  title: Text(
                    'إضافة قرض جديد',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: customTextField(
                            onChanged: (val) {
                              if (val.length > 1) {
                                cubit.checkLoanAmount();
                              } else {
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
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "عدد الدفعات (أشهر)",
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
                            context,
                            controller: context.read<LoanCubit>().benefitController,
                            label: 'نسبة الفائدة (%)',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeUtil.screenHeight * 0.03, left: 10),
                          child: Column(
                            children: [
                              ElevatedButton(
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
                                child: const Text(
                                  'حساب الدفعات',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: ResultsCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
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
                          SizedBox(
                            height: ScreenSizeUtil.screenHeight * 0.02,
                          ),
                          BlocConsumer<ClientsCubit, ClientsState>(
                            listener: (context, state) {
                              if (state is InsertLoanFailure) {
                                customSnackBar(context, state.error);
                              }
                              if (state is InsertLoanSuccess) {
                                customSnackBar(context, 'تمت إضافة القرض');
                                Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              return CustomCircularButton(
                                  label: 'إضافة القرض',
                                  onPressed: () {
                                    context.read<ClientsCubit>().insertLoan(
                                      customerId: id,
                                      amount: context
                                          .read<LoanCubit>()
                                          .loanAmountController
                                          .text,
                                      monthNumber: context
                                          .read<LoanCubit>()
                                          .monthNumber(),
                                      paymentsNumber: 0,
                                      date: intl.DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                                    );
                                  });
                            },
                          )
                        ],
                      ),
                    ),
                    if (context.read<LoanCubit>().isTableShown)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TableButtonsRow(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueGrey,
                              ),
                              child: Column(
                                children: [
                                  LoanPaymentTable(
                                    monthNumber: cubit.monthNumber(),
                                    monthlyOverallPayment:
                                        cubit.monthlyOverallPayment,
                                    loanAmountWithBenefit:
                                        cubit.loanAmountWithBenefit,
                                    monthlyBenefitPayment:
                                        cubit.calcMonthlyBenefitPayment(),
                                    monthlyLoanPayment:
                                        cubit.calcLoanMonthlyPayment(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
