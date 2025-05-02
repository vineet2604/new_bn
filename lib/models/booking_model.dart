// class Booking {
//   final String id;
//   final String customerId;
//   final DateTime date;
//   final String hallName;
//   final double amount;

//   Booking({
//     required this.id,
//     required this.customerId,
//     required this.date,
//     required this.hallName,
//     required this.amount,
//   });

//   factory Booking.fromMap(Map<String, dynamic> data, String documentId) {
//     return Booking(
//       id: documentId,
//       customerId: data['customerId'] ?? '',
//       date: DateTime.parse(data['date']),
//       hallName: data['hallName'] ?? '',
//       amount:
//           (data['amount'] is int)
//               ? (data['amount'] as int).toDouble()
//               : data['amount'] ?? 0.0,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'customerId': customerId,
//       'date': date.toIso8601String(),
//       'hallName': hallName,
//       'amount': amount,
//     };
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class Booking {
//   final String id;
//   final String customerId;
//   final String customerName;
//   final DateTime date;
//   final String hallName;
//   final double amount;
//   final int guests;
//   final String status;
//   final DateTime createdAt;

//   Booking({
//     required this.id,
//     required this.customerId,
//     required this.customerName,
//     required this.date,
//     required this.hallName,
//     required this.amount,
//     required this.guests,
//     this.status = 'pending',
//     required this.createdAt,
//   });

//   factory Booking.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Booking(
//       id: doc.id,
//       customerId: data['customerId'] ?? '',
//       customerName: data['customerName'] ?? 'Unknown',
//       date: (data['date'] as Timestamp).toDate(),
//       hallName: data['hallName'] ?? 'Unknown Hall',
//       amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
//       guests: data['guests'] as int? ?? 0,
//       status: data['status'] as String? ?? 'pending',
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'customerId': customerId,
//       'customerName': customerName,
//       'date': Timestamp.fromDate(date),
//       'hallName': hallName,
//       'amount': amount,
//       'guests': guests,
//       'status': status,
//       'createdAt': Timestamp.fromDate(createdAt),
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String customerId;
  final String customerName;
  final DateTime date;
  final String hallName;
  final double amount;
  final int guests;
  final String status;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.date,
    required this.hallName,
    required this.amount,
    required this.guests,
    this.status = 'pending',
    required this.createdAt,
  });

  // Changed from fromFirestore to fromMap for consistency
  factory Booking.fromMap(Map<String, dynamic> map, String id) {
    return Booking(
      id: id,
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? 'Unknown',
      date: (map['date'] as Timestamp).toDate(),
      hallName: map['hallName'] ?? 'Unknown Hall',
      amount: (map['amount'] as num).toDouble(),
      guests: map['guests'] as int? ?? 0,
      status: map['status'] as String? ?? 'pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'date': Timestamp.fromDate(date),
      'hallName': hallName,
      'amount': amount,
      'guests': guests,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
