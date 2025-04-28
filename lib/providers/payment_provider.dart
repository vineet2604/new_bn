import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/payment_service.dart';
import '../models/payment_model.dart';

final paymentServiceProvider = Provider<PaymentService>(
  (ref) => PaymentService(),
);

final paymentListProvider = FutureProvider<List<Payment>>((ref) async {
  return ref.read(paymentServiceProvider).fetchPayments();
});
