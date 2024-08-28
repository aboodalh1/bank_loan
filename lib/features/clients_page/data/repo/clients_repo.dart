import 'package:dartz/dartz.dart';

abstract class ClientsRepo{

  Future<Either<String,void>>initDB();
  Future<void> insertToClients({required String name, required String date});
  Future<Either<String,dynamic>> getAllClients();
  Future<Either<String,List<Map>>> getAllLoans({required num uId});
  Future <void> deleteData({required int id});
  Future<Either<String,void>>  editClient({required String name, required num id});
}