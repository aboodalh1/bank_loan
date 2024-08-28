import 'package:bank_loan/core/util/network/service_locator.dart';
import 'package:bank_loan/features/clients_page/data/repo/clients_repo_impl.dart';
import 'package:bank_loan/features/loan_page/presentation/view/widgets/custom_circled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../loan_page/presentation/view/loan_screen.dart';
import '../manger/clients_cubit.dart';

class ClientLoanPage extends StatelessWidget {
  const ClientLoanPage({super.key,required this.uId});
  final num uId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsCubit(getIt.get<ClientsRepoImpl>())..getClientLoans(uId: uId),
      child: BlocBuilder<ClientsCubit, ClientsState>(
        builder: (context, state) {
          ClientsCubit cubit = context.read<ClientsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text("قروض الزبون"),
            ),
            body:cubit.loans.length >0? ListView.builder(
              itemCount: cubit.loans.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        colors: [Color(0xFF004F9F), Color(0xFF2077D9)]),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'قرض',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          tooltip: 'تعديل المعلومات',
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          tooltip: 'حذف زبون',
                          onPressed: () {

                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          tooltip: 'إضافة قرض',
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                BlocProvider(
                                  create: (context) => LoanCubit(),
                                  child: Scaffold(body: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: const LoanScreen())),
                                )));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ): Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('لا يوجد قروض جارية لهذا الزبون'),
                  SizedBox(height: 10,),
                  CustomCircularButton(onPressed: (){
                  }, label: 'إضافة قرض')
                ],
              ),
            )
          );
        },
      ),
    );
  }
}
