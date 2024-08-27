abstract class ClientsRepo{

  Future<void>createDataBase();
  Future<void>openDataBase();
  Future<void> insertToDataBase({required String name, required String date});
  Future<void> getFromDB(DBB);
  Future <void> deleteData({required int id});
}