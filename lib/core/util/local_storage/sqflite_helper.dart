import 'package:sqflite/sqflite.dart';

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
  static String costumerId = 'costumerId';
  static Database? clientDB;

  Future<Database?> get db async {
    if (clientDB == null) {
      clientDB = await intialDb();
      return clientDB;
    } else {
      return clientDB;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = '$databasepath/bankLoan.db';
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {}

  _onCreate(Database db, int version) async {
    await db.execute(
        'Create Table $tableNameClient($clientId INTEGER PRIMARY KEY AUTOINCREMENT,$clientName TEXT,$date TEXT)');
    await db.execute(
        'Create Table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,$date TEXT,$amount TEXT,$monthNumber TEXT,$paymentsNumber INTEGER,$costumerId INTEGER,FOREIGN KEY (costumerId) REFERENCES customers(id) ON DELETE CASCADE)');
  }

  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateClient({required String name, required num id}) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(
        'UPDATE client SET $clientName= ? WHERE $clientId =?',
        ['$name', '$id']);
    return response;
  }

  updateLoan({required num paymentsNumber, required num id}) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(
        'UPDATE bank_loan SET paymentsNumber= ? WHERE id =?',
        ['$paymentsNumber', '$id']);
    return response;
  }

  deleteLoan({required num id}) async {
    Database? mydb = await db;
    int response =
        await mydb!.rawDelete('DELETE FROM bank_loan WHERE id = ?', ['$id']);
    return response;
  }

  deleteClient({required num id}) async {
    Database? mydb = await db;
    int response =
        await mydb!.rawDelete('DELETE FROM client WHERE uid = ?', ['$id']);
    return response;
  }
  searchClient({required String name}) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(
        'SELECT * FROM client WHERE $clientName LIKE "%$name%"');
    return response;
  }
}
