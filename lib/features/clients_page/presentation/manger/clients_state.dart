part of 'clients_cubit.dart';

sealed class ClientsState {}

final class ClientsInitial extends ClientsState {}

final class GetClientsSuccess extends ClientsState {}

final class GetClientsFailure extends ClientsState {
  final String error;

  GetClientsFailure({required this.error});
}

final class GetClientsLoading extends ClientsState {}

final class GetLoanSuccess extends ClientsState {}

final class GetLoanFailure extends ClientsState {
  final String error;

  GetLoanFailure({required this.error});
}

final class GetLoansLoading extends ClientsState {}

final class InsertClientLoading extends ClientsState {}

final class InsertClientSuccess extends ClientsState {}

final class InsertClientFailure extends ClientsState {
  final String error;

  InsertClientFailure({required this.error});
}

final class DeleteClientLoading extends ClientsState {}

final class DeleteClientSuccess extends ClientsState {}

final class DeleteClientFailure extends ClientsState {
  final String error;

  DeleteClientFailure({required this.error});
}
final class InitDataLoading extends ClientsState {}

final class InitDataSuccess extends ClientsState {}

final class InitDataFailure extends ClientsState {
  final String error;

  InitDataFailure({required this.error});
}
final class EditClientLoading extends ClientsState {}

final class EditClientSuccess extends ClientsState {}

final class EditClientFailure extends ClientsState {
  final String error;

  EditClientFailure({required this.error});
}
final class InsertLoanLoading extends ClientsState {}

final class InsertLoanSuccess extends ClientsState {}

final class InsertLoanFailure extends ClientsState {
  final String error;

  InsertLoanFailure({required this.error});
}
final class EditLoanLoading extends ClientsState {}

final class EditLoanSuccess extends ClientsState {}

final class EditLoanFailure extends ClientsState {
  final String error;

  EditLoanFailure({required this.error});
}
final class DeleteLoanLoading extends ClientsState {}

final class DeleteLoanSuccess extends ClientsState {}

final class DeleteLoanFailure extends ClientsState {
  final String error;

  DeleteLoanFailure({required this.error});
}

final class HideFab extends ClientsState{}
final class ShowFab extends ClientsState{}
