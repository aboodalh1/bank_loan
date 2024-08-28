import 'package:bank_loan/features/clients_page/presentation/view/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/network/service_locator.dart';
import '../../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../../data/repo/clients_repo_impl.dart';
import '../../manger/clients_cubit.dart';
import 'client_loan_details.dart';
import 'edit_loan_dialog.dart';

class LoanItem extends StatelessWidget {
  const LoanItem(
      {super.key, required this.cubit, required this.uId, required this.index});

  final ClientsCubit cubit;
  final num uId;
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
                    'رقم القرض: ${cubit.loans[index]['id']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'قيمة القرض: ${cubit.loans[index]['amount']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'تاريخ القرض: ${cubit.loans[index]['date']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'عدد الدفعات المنتهية: ${cubit.loans[index]['paymentsNumber']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              tooltip: 'تعديل المعلومات',
              onPressed: () {
                showEditLoanDialog(
                    context, cubit, cubit.loans[index]['id'], uId);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              tooltip: 'حذف القرض',
              onPressed: () {
                showDeleteConfirmation(
                    isClient: false,
                    uId: uId,
                    context: context,
                    title:
                        'هل انت متأكد من انك تريد حذف القرض رقم ${cubit.loans[index]['id']!}؟ \nلا يمكن التراجع عن هذا الخيار.',
                    id: cubit.loans[index]['id'],
                    cubit: cubit,
                    headerTitle: 'حذف القرض');
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_sharp, color: Colors.white),
              tooltip: 'إضافة قرض',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => LoanCubit(),
                                ),
                                BlocProvider(
                                  create: (context) => ClientsCubit(
                                      getIt.get<ClientsRepoImpl>()),
                                ),
                              ],
                              child: Scaffold(
                                  body: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ClientLoanDetails(
                                        paymentsNumbr: '${cubit.loans[index]['paymentsNumber']}',
                                        date: '${cubit.loans[index]['date']}',
                                        monthNumber: '${cubit.loans[index]['monthNumber']}',
                                        amount: '${cubit.loans[index]['amount']}',
                                        benefit: '20',
                                        id: '${cubit.loans[index]['id']}',
                                      ))),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
