import 'package:dartz/dartz.dart';

abstract class ClientsRepo{

  Future<void>createDataBase();
  Future<void> insertToClients({required String name, required String date});
  Future<Either<String,List<Map>>> getFromDB();
  Future <void> deleteData({required int id});
}