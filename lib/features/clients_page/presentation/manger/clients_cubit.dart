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
  final TextEditingController searchController = TextEditingController();
  final TextEditingController paymentsController = TextEditingController();

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
    emit(GetClientsLoading());
    clients = [];
    var result = await clientsRepo.getAllClients();
    result.fold((error) {
      emit(GetClientsFailure(error: error.toString()));
    }, (response) {
      response.forEach((element) {
        clients.add(element);
      });
      emit(GetClientsSuccess());
    });
  }

  Future<void> searchClient({required String name}) async {
    clients = [];
    emit(GetClientsLoading());
    var result = await clientsRepo.searchClients(name: name);
    result.fold((error) {
      emit(GetClientsFailure(error: error.toString()));
    }, (response) {
      response.forEach((element) {
        clients.add(element);
      });
      emit(GetClientsSuccess());
    });
  }

  Future<void> getClientLoans({required num uId}) async {
    loans.clear();
    emit(GetLoansLoading());
    var result = await clientsRepo.getAllLoans(uId: uId);
    result.fold((error) {
      emit(GetLoanFailure(error: error.toString()));
    }, (response) {
      response.forEach((element) {
        loans.add(element);
      });
      emit(GetLoanSuccess());
    });
  }

  Future<void> insertClient() async {
    if (nameController.text.isNotEmpty && dateController.text.isNotEmpty ) {
      if(nameController.text.length < 30 && nameController.text.length>2){
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
      }else{
        emit(InsertClientFailure(error: 'لا يمكن للإسم أن يكون اكثر من 30 حرف و أقل من ثلاث أحرف'));
      }
    } else {
      emit(InsertClientFailure(error: "جميع الحقول مطلوبة"));
    }
  }

  Future<void> insertLoan(
      {required String amount,
      required String date,
      required num monthNumber,
      required num paymentsNumber,
      required num customerId}) async {
    if (amount.isNotEmpty && date.isNotEmpty && monthNumber > 0) {
      emit(InsertLoanLoading());
      var result = await clientsRepo.insertToLoans(
          amount: amount,
          customerId: customerId,
          date: date,
          monthNumber: monthNumber,
          paymentsNumber: 0);
      result.fold((error) {
        emit(InsertLoanFailure(error: error.toString()));
      }, (response) {
        emit(InsertLoanSuccess());
        getClientLoans(uId: customerId);
      });
    } else {
      emit(InsertLoanFailure(error: "جميع الحقول مطلوبة"));
    }
  }

  Future<void> editClient({required num id}) async {
    if(editNameController.text.isEmpty){
      emit(EditClientFailure(error: 'لا يمكن للإسم أن يكون فارغاً'));
    }
    else{
    emit(EditLoanLoading());
    var result =
        await clientsRepo.editClient(id: id, name: editNameController.text);
    result.fold((error) {
      emit(EditLoanFailure(error: error.toString()));
    }, (r) {
      editNameController.clear();
      emit(EditLoanSuccess());
      getClients();
    });}
  }

  Future<void> editLoan(
      {required num id,
      required num paymentsNumber,
      required num costumerId}) async {
    emit(EditClientLoading());
    var result =
        await clientsRepo.editLoan(paymentsNumber: paymentsNumber, id: id);
    result.fold((error) {
      emit(EditClientFailure(error: error.toString()));
    }, (r) {
      editNameController.clear();
      emit(EditClientSuccess());
      getClientLoans(uId: costumerId);
    });
  }

  Future<void> deleteClient({required int id}) async {
    emit(DeleteClientLoading());
    await clientsRepo.deleteClient(id: id).then((value) {
      getClients();
      emit(DeleteClientSuccess());
    }).catchError((e) {
      emit(DeleteClientFailure(error: e.toString()));
    });
  }

  Future<void> deleteLoan({required int id, required num uId}) async {
    emit(DeleteLoanLoading());
    await clientsRepo.deleteLoan(id: id).then((value) {
      getClientLoans(uId: uId);
      emit(DeleteLoanSuccess());
    }).catchError((e) {
      emit(DeleteLoanFailure(error: e.toString()));
    });
  }
}
