import 'package:bank_loan/core/util/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/screen_size.dart';
import '../../../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../../../loan_page/presentation/view/widgets/custom_circled_button.dart';
import '../../../../../loan_page/presentation/view/widgets/loan_payments_table/loan_payments_table.dart';
import '../../../../../loan_page/presentation/view/widgets/results_card.dart';

class ClientLoanDetails extends StatefulWidget {
  const ClientLoanDetails(
      {super.key,
      required this.id,
      required this.amount,
      required this.benefit,
      required this.paymentsNumbr,
      required this.date,
      required this.monthNumber});

  final String id;
  final String amount;
  final String benefit;
  final String monthNumber;
  final String paymentsNumbr;
  final String date;

  @override
  State<ClientLoanDetails> createState() => _ClientLoanDetailsState();
}

class _ClientLoanDetailsState extends State<ClientLoanDetails> {
  @override
  void initState() {
    super.initState();
    context.read<LoanCubit>().loanAmountController.text = widget.amount;
    context.read<LoanCubit>().benefitController.text = widget.benefit;
    context.read<LoanCubit>().monthNumberController.text = widget.monthNumber;
    context.read<LoanCubit>().calcResults(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        var cubit = context.read<LoanCubit>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: CustomScrollView(slivers: [
              SliverAppBar(
                  backgroundColor: Color(0xFFF7F7F7),
                  floating: true,
                  title: Text(
                    ' تفاصيل قرض رقم ${widget.id}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomText(
                            label: '  مبلغ القرض: ${widget.amount}',
                          ),
                          CustomText(
                            label: '  عدد الأشهر: ${widget.monthNumber}',
                          ),
                          CustomText(
                            label: '  الفائدة (%): ${widget.benefit}',
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            label:
                                '  الدفعات المنتهية: ${widget.paymentsNumbr}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            label: '  تاريخ التقديم: ${widget.date}',
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
                            ],
                          ),
                          SizedBox(
                            height: ScreenSizeUtil.screenHeight * 0.02,
                          ),
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
            ]),
          ),
        );
      },
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        height: ScreenSizeUtil.screenHeight * 0.045,
        decoration: BoxDecoration(
            color: defaultColor, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          textAlign: TextAlign.start,
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        )));
  }
}

class TableButtonsRow extends StatelessWidget {
  const TableButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.print, color: Colors.black),
          onPressed: () {
            context.read<LoanCubit>().printTable(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
          onPressed: () {
            context.read<LoanCubit>().saveAsPdf(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.table_chart, color: Colors.green),
          onPressed: () {
            context.read<LoanCubit>().saveAsXls(context);
          },
        ),
      ],
    );
  }
}
