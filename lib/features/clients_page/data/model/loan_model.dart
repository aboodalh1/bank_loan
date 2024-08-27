List<Map> loans = [];

class Loan {
  final int? id;
  final String amount;
  final String monthNumber;
  final num customerId;
  final String paymentsNumber;

  Loan(
      {this.id,
      required this.amount,
      required this.monthNumber,
      required this.customerId,
      required this.paymentsNumber}); // Convert a Client object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'monthNumber': monthNumber,
      'customerId': customerId,
      'paymentsNumber': paymentsNumber
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map['id'],
      amount: map['amount'],
      monthNumber: map['monthNumber'],
      customerId: map['customerId'],
      paymentsNumber: map['paymentsNumber'],
    );
  }
}
