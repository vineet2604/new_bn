class Payment {
  final String id;
  final String bookingId;
  final double amount;
  final DateTime date;
  final String status;

  Payment({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory Payment.fromMap(Map<String, dynamic> data, String documentId) {
    return Payment(
      id: documentId,
      bookingId: data['bookingId'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
