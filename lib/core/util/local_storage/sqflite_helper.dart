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
  static String customerId = 'customerId';
  late Database clientDB;

  void openDataBase()async{
     await openDatabase(databaseName);
  }

  void createDataBase() {
    openDatabase(databaseName,
      version: 1,
      onCreate: (db, version) async {
        print('Data Base have Created successfully');
        await db.execute(
            'Create Table $tableNameClient($clientId INTEGER PRIMARY KEY AUTOINCREMENT,$clientName TEXT,$date TEXT)');
        await db.execute('Create Table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,$amount TEXT,$monthNumber TEXT,$paymentsNumber INTEGER,$customerId INTEGER,FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE)')
        .then((value) {
        print('Tables Created Successfully');
        }).catchError((error) {
        print('error when tables Created ${error.toString()}');
        });
      },
      onOpen: (dBB) {
        getFromDB(dBB);
        print('Data Base Opened Successfully');
      },
    ).then((value) {
      clientDB = value;
    });
  }

  void insertToClient({
    required String name,
    required String date,
  }) {
    clientDB.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO $tableNameClient($clientName,date) VALUES("name","date")'
      ).then((value) {
        print('$value+ Gg');
        getFromDB(clientDB);
      }).catchError((error) {
        print('${error.toString()}');
      });
    });
  }

  void insertToDataLoan({
    required String amount,
    required String monthNumber,
    required String paymentsNumber,
    required String customerId
  }) {
    clientDB.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO $tableName($amount,$monthNumber,$paymentsNumber,$customerId) VALUES("amount","monthNumber","paymentsNumber","customerId")'
      ).then((value) {
        print('$value+ Gg');
        getFromDB(clientDB);
      }).catchError((error) {

      });
  });
  }

  void getFromDB(DBB) {
    DBB.rawQuery('SELECT * FROM $tableNameClient').then((value) {
      print(value.toString());
      DBB.rawQuery('SELECT * FROM $tableName').then((value) {
        print(value.toString());
      });
      value.forEach((element) {
        if (element['status'] == 'new') {
          // newTasks.add(element);
        } else if (element['status'] == 'done') {
          // doneTasks.add(element);}
        } else {
          // archivedTasks.add(element); }
        }
      });
      // emit(GetFromDataBaseState());
    });
  }

  void updateClientData({
    required String name,
    required num id
  }) {
    clientDB.rawUpdate('UPDATE task SET $clientName= ? WHERE $clientId =?',
        [name, '$id']).then((value) {
      getFromDB(clientDB);
    });
  }

  void removeData({
    required int id
  }) {
    clientDB.rawDelete(
        'DELETE FROM $tableNameClient WHERE $clientId = ?', ['$id']).then((value) {
      getFromDB(clientDB);
    });
  }


}