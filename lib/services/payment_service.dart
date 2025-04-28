import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment_model.dart';

class PaymentService {
  final CollectionReference _paymentsCollection = FirebaseFirestore.instance
      .collection('payments');

  Future<void> addPayment(Payment payment) async {
    await _paymentsCollection.add(payment.toMap());
  }

  Future<List<Payment>> fetchPayments() async {
    final querySnapshot = await _paymentsCollection.get();
    return querySnapshot.docs
        .map(
          (doc) => Payment.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Future<void> updatePayment(Payment payment) async {
    await _paymentsCollection.doc(payment.id).update(payment.toMap());
  }

  Future<void> deletePayment(String id) async {
    await _paymentsCollection.doc(id).delete();
  }
}
