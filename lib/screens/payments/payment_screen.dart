import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/payment_provider.dart';
//import '../../models/payment_model.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentList = ref.watch(paymentListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Payments")),
      body: paymentList.when(
        data:
            (payments) => ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final p = payments[index];
                return ListTile(
                  title: Text("Booking: ${p.bookingId}"),
                  subtitle: Text("Amount: ₹${p.amount.toStringAsFixed(2)}"),
                  trailing: Text(p.status),
                );
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
