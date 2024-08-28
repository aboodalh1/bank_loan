import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/clients_repo.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  final ClientsRepo clientsRepo;

  ClientsCubit(this.clientsRepo) : super(ClientsInitial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> createDataBase() async {
    emit(InitDataLoading());
    var result = await clientsRepo.initDB();
    result.fold((error) {
      emit(InitDataFailure(error: error.toString()));
    }, (r) {
      emit(InitDataSuccess());
      getClients();
    });
  }

  List<Map> clients = [];
  List<Map> loans = [];

  Future<void> getClients() async {
    clients = [];
    emit(GetClientsLoading());
    var result = await clientsRepo.getAllClients();
    result.fold((error) {
      print(error.toString());
      emit(GetClientsFailure(error: error.toString()));
    }, (response) {
      response.forEach((element) {
        clients.add(element);
      });
      emit(GetClientsSuccess());
    });
  }

  Future<void> getClientLoans({required num uId}) async {
    emit(GetClientsLoading());
    var result = await clientsRepo.getAllLoans(uId: uId);
    result.fold((error) {
      print(error.toString());
      emit(GetClientsFailure(error: error.toString()));
    }, (response) {
      response.forEach((element) {
        loans.add(element);
      });
      emit(GetClientsSuccess());
    });
  }

  Future<void> insertClient() async {
    if (nameController.text.isNotEmpty && dateController.text.isNotEmpty) {
      emit(InsertClientLoading());
      await clientsRepo
          .insertToClients(name: nameController.text, date: dateController.text)
          .then((value) {
        nameController.clear();
        dateController.clear();
        getClients();
        emit(InsertClientSuccess());
      }).catchError((e) {
        emit(InsertClientFailure(error: e.toString()));
      });
    } else {
      emit(InsertClientFailure(error: "جميع الحقول مطلوبة"));
    }
  }

  Future<void> editClient({required num id}) async {
    emit(EditClientLoading());
    var result = await clientsRepo.editClient(id: id, name: editNameController.text);
    result.fold((error) {
      emit(EditClientFailure(error: error.toString()));
    }, (r) {
      editNameController.clear();
      emit(EditClientSuccess());
      getClients();
    });
  }
  Future<void> deleteData({required int id}) async {
    emit(DeleteClientLoading());
    await clientsRepo.deleteData(id: id).then((value) {
      getClients();
      emit(DeleteClientSuccess());
    }).catchError((e) {
      emit(DeleteClientFailure(error: e.toString()));
    });
  }
}
