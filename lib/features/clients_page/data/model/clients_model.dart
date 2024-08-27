List<Map> clients = [];
class Client {
  final int? id;
  final String name;
  final String date;

  Client({this.id, required this.name, required this.date});
  // Convert a Client object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'clientName': name,
      'date': date,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['uid'],
      name: map['clientName'],
      date: map['date'],
    );
  }
}