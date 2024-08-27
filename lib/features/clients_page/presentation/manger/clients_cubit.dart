import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/clients_repo.dart';
part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  final ClientsRepo clientsRepo;

  ClientsCubit(this.clientsRepo) : super(ClientsInitial());

  Future<void> openDataBase() async{
    clientsRepo.openDataBase();
  }
  Future<void>createDataBase() async{
    clientsRepo.createDataBase();
  }
  Future<void> insertToDataBase({required String name, required String date}) async{
    clientsRepo.insertToDataBase(name: name, date: date);
  }
  Future<void> getFromDB(DBB) async{
    clientsRepo.getFromDB(DBB);
  }
  Future<void> deleteData({required int id}) async{
    clientsRepo.deleteData(id: id);
  }
}
