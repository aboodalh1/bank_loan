import 'package:dartz/dartz.dart';

abstract class ClientsRepo {
  Future<Either<String, void>> initDB();

  Future<void> insertToClients({required String name, required String date});

  Future<Either<String, void>> insertToLoans(
      {required String date,
      required String amount,
      required num monthNumber,
      required num paymentsNumber,
      required num customerId});

  Future<Either<String, dynamic>> getAllClients();

  Future<Either<String, dynamic>> searchClients({required String name});

  Future<Either<String, List<Map>>> getAllLoans({required num uId});

  Future<void> deleteClient({required int id});

  Future<void> deleteLoan({required int id});

  Future<Either<String, void>> editClient(
      {required String name, required num id});

  Future<Either<String, void>> editLoan(
      {required num id, required num paymentsNumber});
}
