import 'package:bank_loan/core/util/local_storage/sqflite_helper.dart';
import 'package:bank_loan/features/clients_page/data/repo/clients_repo.dart';

class ClientsRepoImpl implements ClientsRepo{
  final SqfliteHelper sqfliteHelper;
  ClientsRepoImpl(this.sqfliteHelper);
  @override
  Future<void> createDataBase() async {
    sqfliteHelper.createDataBase();
  }

  @override
  Future<void> getFromDB(DBB) async{
    sqfliteHelper.getFromDB(DBB);
  }

  @override
  Future<void> insertToDataBase({required String name, required String date}) async{
    sqfliteHelper.insertToClient(name: name, date: date);
  }

  @override
  Future<void> deleteData({required int id}) async{
    sqfliteHelper.removeData(id: id);
  }

  @override
  Future<void> openDataBase() async{
    sqfliteHelper.openDataBase();
  }


}