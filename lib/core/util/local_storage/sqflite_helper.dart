import 'package:bank_loan/features/clients_page/data/model/clients_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../features/clients_page/data/model/loan_model.dart';

class SqfliteHelper {
  static String tableName = "bank_loan";
  static String databaseName = "clientsDB.db";
  static String tableNameClient = "client";
  static String clientName = "clientName";
  static String clientId = 'uid';
  static String date = 'date';
  static String amount = 'amount';
  static String monthNumber = 'monthNumber';
  static String paymentsNumber = 'paymentsNumber';
  static String customerId = 'customerId';
  late Database clientDB;

  Future<void> createDataBase() async {
    openDatabase(
      databaseName,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'Create Table $tableNameClient($clientId INTEGER PRIMARY KEY AUTOINCREMENT,$clientName TEXT,$date TEXT)');
        await db.execute(
            'Create Table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,$amount TEXT,$monthNumber TEXT,$paymentsNumber INTEGER,$customerId INTEGER,FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE)');
      },
      onOpen: (dBB) {
        getClients(dBB);
      },
    ).then((value) {
      clientDB = value;
      getClients(clientDB);
    });
  }

  void insertToLoan(
      {required String amount,
      required String monthNumber,
      required String paymentsNumber,
      required String customerId}) {
    clientDB.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO $tableName($amount,$monthNumber,$paymentsNumber,$customerId) VALUES("amount","monthNumber","paymentsNumber","customerId")');
    });
  }

  Future<void> getClients(DBB) async {
    DBB.rawQuery('SELECT * FROM $tableNameClient').then((value) {
      clients = [];
      print(value);
      Client? client;
      if (clients.isEmpty) {
        value.forEach((element) {
          client = Client.fromMap(element);
          clients.add(client!.toMap());
        });
      }
    });
  }

  Loan? loan;

  Future<void> getLoan(DBB) async {
    DBB.rawQuery('SELECT * FROM $tableName').then((value) {
      value.forEach((element) {
        loan = Loan.fromMap(element);
        loans.add(loan!.toMap());
      });
    });
  }

  void updateClientData({required String name, required num id}) {
    clientDB.rawUpdate('UPDATE task SET $clientName= ? WHERE $clientId =?',
        [name, '$id']).then((value) {
      getClients(clientDB);
    });
  }

  Future<void> insertToClient({
    required String name,
    required String date,
  }) async {
    clientDB.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO $tableNameClient($clientName,date) VALUES("$name","$date")');
    });
    getClients(clientDB);
  }

  Future<void> removeData({required int id}) async {
    clientDB
        .rawDelete('DELETE FROM $tableNameClient WHERE $clientId = ?', ['$id']);
    getClients(clientDB);
  }

}
