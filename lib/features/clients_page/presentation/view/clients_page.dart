import 'package:bank_loan/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
import 'package:bank_loan/features/clients_page/presentation/view/claients_loan_page.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/add_client_dialog.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/delet_dialog.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/edit_client_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsState>(
      listener: (context, state) {
        if (state is InsertClientSuccess) {
          customSnackBar(context, 'تمت إضافة الزبون');
        }
        if (state is DeleteClientSuccess) {
          customSnackBar(context, 'تم حذف الزبون');
        }
        if (state is EditClientSuccess) {
          customSnackBar(context, 'تمت إضافة الزبون');
        }
        if (state is EditClientFailure ) {
          customSnackBar(context, state.error.toString());
        }

      },
      builder: (context, state) {
        var cubit = context.read<ClientsCubit>();
        if(state is GetClientsLoading){
          return Scaffold(body: SizedBox(height: 20,width: 20,child: CircularProgressIndicator(),),);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('العملاء'),
          ),
          body: ListView.builder(
            itemCount: cubit.clients.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [Color(0xFF004F9F), Color(0xFF2077D9)]),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.clients[index]['clientName']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cubit.clients[index]['date']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        tooltip: 'تعديل المعلومات',
                        onPressed: () {
                          showEditClientDialog(context,cubit,cubit.clients[index]['uid']);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        tooltip: 'حذف زبون',
                        onPressed: () {
                          print(cubit.clients[index]['uid']);
                          showDeleteConfirmation(
                              context,
                              cubit.clients[index]['clientName']!,
                              cubit.clients[index]['uid'],
                              cubit);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        tooltip: 'إضافة قرض',
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                               Directionality(textDirection: TextDirection.rtl,child: ClientLoanPage(
                                uId: cubit.clients[index]['uid'],
                              ))
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAddClientDialog(context, cubit);
            },
            backgroundColor: Color(0xFF004F9F),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
