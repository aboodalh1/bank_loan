import 'package:bank_loan/core/util/local_storage/sqflite_helper.dart';
import 'package:bank_loan/features/clients_page/data/repo/clients_repo.dart';
import 'package:dartz/dartz.dart';

class ClientsRepoImpl implements ClientsRepo{
  final SqfliteHelper sqfliteHelper;
  ClientsRepoImpl(this.sqfliteHelper);
  @override
  Future<void> createDataBase() async {
    sqfliteHelper.createDataBase();
  }

  @override
  Future<Either<String,List<Map>>> getFromDB() async{
    try{
      var response = await sqfliteHelper.clientDB.rawQuery('SELECT * FROM client');
      return right(response);
    }catch(e){
      return left(e.toString());
    }
  }

  @override
  Future<void> insertToClients({required String name, required String date}) async{
    sqfliteHelper.insertToClient(name: name, date: date);
    getFromDB();
  }

  @override
  Future<void> deleteData({required int id}) async{
    sqfliteHelper.removeData(id: id);
    getFromDB();
  }


}