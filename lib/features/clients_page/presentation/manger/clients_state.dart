part of 'clients_cubit.dart';

sealed class ClientsState {}

final class ClientsInitial extends ClientsState {}

final class GetClientsSuccess extends ClientsState {}

final class GetClientsFailure extends ClientsState {
  final String error;

  GetClientsFailure({required this.error});
}

final class GetClientsLoading extends ClientsState {}

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
