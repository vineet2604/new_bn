class Booking {
  final String id;
  final String customerId;
  final DateTime date;
  final String hallName;
  final double amount;

  Booking({
    required this.id,
    required this.customerId,
    required this.date,
    required this.hallName,
    required this.amount,
  });

  factory Booking.fromMap(Map<String, dynamic> data, String documentId) {
    return Booking(
      id: documentId,
      customerId: data['customerId'] ?? '',
      date: DateTime.parse(data['date']),
      hallName: data['hallName'] ?? '',
      amount:
          (data['amount'] is int)
              ? (data['amount'] as int).toDouble()
              : data['amount'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'date': date.toIso8601String(),
      'hallName': hallName,
      'amount': amount,
    };
  }
}
