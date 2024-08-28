
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/network/service_locator.dart';
import '../../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../data/repo/clients_repo_impl.dart';
import '../../manger/clients_cubit.dart';
import '../add_client_loan_screen.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.uId,
  });

  final num uId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 140,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create:(context)=> ClientsCubit(
                              getIt.get<ClientsRepoImpl>()),
                        ),
                        BlocProvider(
                          create: (context) => LoanCubit(),
                        ),
                      ],
                      child: AddClientLoanScreen(
                        id: uId,
                      ),
                    )),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("إضافة قرض",
                style: TextStyle(color: Colors.white, height: -0.2)),
            SizedBox(width: 5,),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
