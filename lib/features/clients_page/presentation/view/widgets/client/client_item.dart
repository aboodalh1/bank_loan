import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manger/clients_cubit.dart';
import '../../clients_loan_page.dart';
import '../delete_dialog.dart';
import 'edit_client_dialog.dart';

class ClientItem extends StatelessWidget {
  const ClientItem({
    super.key,
    required this.cubit,
    required this.index,
  });

  final ClientsCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                showEditClientDialog(
                    context, cubit, cubit.clients[index]['uid']);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              tooltip: 'حذف زبون',
              onPressed: () {
                showDeleteConfirmation(
                  isClient: true,
                  headerTitle: 'حذف زبون',
                  title: 'هل انت متأكد من انك تريد حذف  ${cubit.clients[index]['clientName']!}؟ \nلا يمكن التراجع عن هذا الخيار.',
                    context: context,
                    id: cubit.clients[index]['uid'],
                    cubit: cubit);
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_sharp, color: Colors.white),
              tooltip: 'عرض القروض',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value: cubit
                                ..getClientLoans(
                                    uId: cubit.clients[index]['uid']),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ClientLoanPage(
                                  cubit: cubit,
                                  clientName: cubit.clients[index]
                                      ['clientName']!,
                                  uId: cubit.clients[index]['uid'],
                                ),
                              ),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
