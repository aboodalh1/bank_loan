import 'package:bank_loan/core/util/network/service_locator.dart';
import 'package:bank_loan/features/clients_page/data/repo/clients_repo_impl.dart';
import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
import 'package:bank_loan/features/clients_page/presentation/view/clients_page.dart';
import 'package:bank_loan/features/loan_page/presentation/view/loan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../loan_page/presentation/manger/loan_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  List<Widget> screens = [
    BlocProvider(
      create: (context) => LoanCubit(),
      child: const LoanScreen(),
    ),
    BlocProvider(
      create: (context) => ClientsCubit(getIt.get<ClientsRepoImpl>())..createDataBase(),
      child: const ClientsPage(),
    )
  ];
}
