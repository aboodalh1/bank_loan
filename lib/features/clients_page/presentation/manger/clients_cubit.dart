import 'package:bank_loan/core/util/local_storage/sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/clients_repo.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  final ClientsRepo clientsRepo;

  ClientsCubit(this.clientsRepo) : super(ClientsInitial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> createDataBase() async {
    emit(GetClientsLoading());
    await clientsRepo.createDataBase().then((value) {
      emit(GetClientsSuccess());
    }).catchError((e) {
      emit(GetClientsFailure(error: e.toString()));
    });
  }

  Future<void> getFromDB() async {
    emit(GetClientsLoading());
    clientsRepo.getFromDB().then((value) {
      emit(GetClientsLoading());
    }).catchError((e) {
      emit(GetClientsFailure(error: e.toString()));
    });
  }

  Future<void> insertClient() async {
    emit(InsertClientLoading());
    if (nameController.text.isNotEmpty && dateController.text.isNotEmpty) {
      await clientsRepo.insertToClients(
          name: nameController.text, date: dateController.text).then((value) {
        nameController.clear();
        dateController.clear();
        getFromDB();
        emit(InsertClientSuccess());
      }).catchError((e){
        emit(InsertClientFailure(error: e.toString()));
      });
    }
  }

  Future<void> deleteData({required int id}) async {
    emit(DeleteClientLoading());
    await clientsRepo.deleteData(id: id).then((value) {
      getFromDB();
      emit(DeleteClientSuccess());
    }).catchError((e) {
      emit(DeleteClientFailure(error: e.toString()));
    });
  }
}
