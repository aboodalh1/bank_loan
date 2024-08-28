import 'package:bank_loan/core/util/screen_size.dart';
import 'package:bank_loan/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/add_client_dialog.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/client_item.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/clients_search_bar.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/empty_loan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsState>(
      buildWhen: (previous, current) => current is! GetClientsLoading,
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
        if (state is EditClientFailure) {
          customSnackBar(context, state.error.toString());
        }
        if (state is InsertClientFailure) {
          customSnackBar(context, state.error.toString());
        }
      },
      builder: (context, state) {
        var cubit = context.read<ClientsCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('الزبائن'),
          ),
          body: cubit.clients.isEmpty? EmptyClientScreen(cubit: cubit,):SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: ClientsSearchBar(cubit: cubit),
                ),
                SizedBox(
                  height: ScreenSizeUtil.screenHeight * 0.7,
                  child: ListView.builder(
                    itemCount: cubit.clients.length,
                    itemBuilder: (context, index) {
                      return ClientItem(cubit: cubit, index: index);
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ClientsFloatingButton(cubit: cubit),
        );
      },
    );
  }
}

class ClientsFloatingButton extends StatelessWidget {
  const ClientsFloatingButton({
    super.key,
    required this.cubit,
  });

  final ClientsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 140,
      child: FloatingActionButton(
        onPressed: () {
          showAddClientDialog(context, cubit);
        },
        backgroundColor: const Color(0xFF004F9F),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("إضافة زبون",
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
