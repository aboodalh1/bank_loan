import 'package:bank_loan/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/custom_floating_button.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/empty_loan_screen.dart';
import 'package:bank_loan/features/clients_page/presentation/view/widgets/loan_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/screen_size.dart';
import '../manger/clients_cubit.dart';

class ClientLoanPage extends StatelessWidget {

  final num uId;
  final String clientName;
  final ClientsCubit cubit;
  const ClientLoanPage(
      {super.key, required this.uId, required this.clientName, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsState>(
      listener: (contxt,state){
        if(state is EditLoanSuccess){
          customSnackBar(context, 'تم تعديل الدفعات');
        }
      },
      builder: (context, state) {
        if(state is GetLoansLoading){
          return Scaffold(body: const Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomFloatingButton(uId: uId),
            ),
            appBar: AppBar(
              title: Text("قروض $clientName",style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),),
            ),
            body: cubit.loans.length > 0
                ? ListView.builder(
              itemCount: cubit.loans.length,
              itemBuilder: (context, index) {
                return LoanItem(cubit: cubit, uId: uId,index: index,);
              },
            )
                : EmptyLoanScreen(uId: uId));
      },
    );
  }
}



