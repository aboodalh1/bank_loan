import 'package:bank_loan/features/clients_page/presentation/view/widgets/client/add_client_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/network/service_locator.dart';
import '../../../../../../core/util/screen_size.dart';
import '../../../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../../../loan_page/presentation/view/widgets/custom_circled_button.dart';
import '../../../../data/repo/clients_repo_impl.dart';
import '../../../manger/clients_cubit.dart';
import '../../add_client_loan_screen.dart';

class EmptyLoanScreen extends StatelessWidget {
  const EmptyLoanScreen({
    super.key,
    required this.uId,
  });

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
                              BlocProvider(
                                create: (context) =>
                                    ClientsCubit(
                                        getIt.get<ClientsRepoImpl>()),
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
class EmptyClientScreen extends StatelessWidget {
  const EmptyClientScreen({
    super.key,
    required this.cubit
  });
  final ClientsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('لا يوجد زبائن بعد'),
          const SizedBox(
            height: 10,
          ),
          CustomCircularButton(
              onPressed: () {
              showAddClientDialog(context, cubit);
              },
              label: 'إضافة زيون')
        ],
      ),
    );
  }
}