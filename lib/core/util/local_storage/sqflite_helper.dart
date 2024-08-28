import 'package:sqflite/sqflite.dart';

// class SqfliteHelper {




//   void updateClientData({required String name, required num id}) {
//     clientDB!.rawUpdate('UPDATE task SET $clientName= ? WHERE $clientId =?',
//         [name, '$id']).then((value) {});
//   }
//
//   Future<void> insertToClient({
//     required String name,
//     required String date,
//   }) async {
//     clientDB!.transaction((txn) async {
//       txn.rawInsert(
//           'INSERT INTO $tableNameClient($clientName,date) VALUES("$name","$date")');
//     });
//   }
//
//   Future<void> removeData({required int id}) async {
//     clientDB!
//         .rawDelete('DELETE FROM $tableNameClient WHERE $clientId = ?', ['$id']);
//   }
// }

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
  static Database? clientDB ;

  Future<Database?> get db async {
    if (clientDB == null){
      clientDB  = await intialDb() ;
      return clientDB ;
    }else {
      return clientDB ;
    }
  }


  intialDb() async {
    String databasepath = await getDatabasesPath() ;
    String path = '$databasepath/wael.db' ;
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 3  , onUpgrade:_onUpgrade ) ;
    return mydb ;
  }

  _onUpgrade(Database db , int oldversion , int newversion ) {

  }

  _onCreate(Database db , int version) async {
    await db.execute(
        'Create Table $tableNameClient($clientId INTEGER PRIMARY KEY AUTOINCREMENT,$clientName TEXT,$date TEXT)');
    await db.execute(
        'Create Table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,$date TEXT,$amount TEXT,$monthNumber TEXT,$paymentsNumber INTEGER,$customerId INTEGER,FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE)');

  }

  Future<List<Map>>readData(String sql) async {
    Database? mydb = await db ;
    List<Map> response = await  mydb!.rawQuery(sql);
    print(response);
    return response ;
  }
  insertData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawInsert(sql);
    return response ;
  }
  updateData({required String name,required num id}) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawUpdate('UPDATE client SET $clientName= ? WHERE $clientId =?',['$name', '$id']);
    return response ;
  }
  deleteData({required num id}) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawDelete('DELETE FROM client WHERE uid = ?', ['$id']);
    print(response);
    return response ;
  }

}