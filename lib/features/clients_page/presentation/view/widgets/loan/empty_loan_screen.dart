import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/screen_size.dart';
import '../../../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../../../loan_page/presentation/view/widgets/custom_circled_button.dart';
import '../../../manger/clients_cubit.dart';
import '../../add_client_loan_screen.dart';

class EmptyLoanScreen extends StatelessWidget {
  const EmptyLoanScreen({
    super.key,
    required this.uId,
    required this.cubit,
  });
  final ClientsCubit cubit;
  final num uId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text('لا يوجد قروض جارية لهذا الزبون',style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),),
          const SizedBox(
            height: 10,
          ),
          CustomCircularButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => LoanCubit(),
                              ),
                              BlocProvider.value(
                               value: cubit,
                              ),
                            ],
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: AddClientLoanScreen(
                                  id: uId,
                                ))),
                  ),
                );
              },
              label: 'إضافة قرض')
        ],
      ),
    );
  }
}