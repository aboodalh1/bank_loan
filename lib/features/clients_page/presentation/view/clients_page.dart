import 'package:bank_loan/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:bank_loan/features/clients_page/data/model/clients_model.dart';
import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/add_client_dialog.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/delet_dialog.dart';
import 'package:bank_loan/features/loan_page/presentation/manger/loan_cubit.dart';
import 'package:bank_loan/features/loan_page/presentation/view/loan_screen.dart';
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
      },
      builder: (context, state) {
        var cubit = context.read<ClientsCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('العملاء'),
          ),
          body: ListView.builder(
            itemCount: clients.length,
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
                              clients[index]['clientName']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              clients[index]['date']!,
                              style: const TextStyle(color: Colors.white),
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
                          showDeleteConfirmation(
                              context,
                              clients[index]['clientName']!,
                              clients[index]['uid'],
                              cubit);
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
