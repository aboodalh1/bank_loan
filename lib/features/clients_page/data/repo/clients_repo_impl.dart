import 'package:bank_loan/core/util/local_storage/sqflite_helper.dart';
import 'package:bank_loan/features/clients_page/data/repo/clients_repo.dart';
import 'package:dartz/dartz.dart';

class ClientsRepoImpl implements ClientsRepo{
  final SqfliteHelper sqfliteHelper;
  ClientsRepoImpl(this.sqfliteHelper);
  @override
  Future<Either<String,void>> initDB() async {
    try{
       await sqfliteHelper.intialDb();
       return right(null);
    }catch(e){
        return left(e.toString());
    }
  }

  @override
  Future<Either<String,dynamic>> getAllClients() async{
    try{
      var response = await sqfliteHelper.readData('SELECT * FROM client');
      return right(response);
    }catch(e){
      return left(e.toString());
    }
  }
  @override
  Future<Either<String,List<Map>>> getAllLoans({required num uId}) async{
    try{
      var response = await sqfliteHelper.readData('SELECT * FROM bank_loan WHERE uId = $uId');
      return right(response);
    }catch(e){
      return left(e.toString());
    }
  }

  @override
  Future<void> insertToClients({required String name, required String date}) async{
    sqfliteHelper.insertData('INSERT INTO client(clientName,date) VALUES("$name","$date")');
  }

  @override
  Future<Either<String,void>> editClient({required String name, required num id}) async{
    try{
      await sqfliteHelper.updateData(name: name ,id: id);
      return right(null);
    }catch(e){
      return left(e.toString());
    }
  }

  @override
  Future<void> deleteData({required num id}) async{
    sqfliteHelper.deleteData(id: id);
  }

}