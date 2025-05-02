// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../models/booking_model.dart';
// import '../../providers/booking_provider.dart';

// class BookingCard extends ConsumerWidget {
//   final Booking booking;

//   const BookingCard({Key? key, required this.booking}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         title: Text(booking.hallName),
//         subtitle: Text('Date: ${booking.date.toLocal()}'),
//         trailing: PopupMenuButton<String>(
//           onSelected: (value) async {
//             if (value == 'edit') {
//               _showEditBookingDialog(context, ref);
//             } else if (value == 'delete') {
//               _confirmDelete(context, ref);
//             }
//           },
//           itemBuilder:
//               (context) => [
//                 PopupMenuItem(value: 'edit', child: Text('Edit')),
//                 PopupMenuItem(value: 'delete', child: Text('Delete')),
//               ],
//         ),
//       ),
//     );
//   }

//   void _showEditBookingDialog(BuildContext context, WidgetRef ref) {
//     final hallController = TextEditingController(text: booking.hallName);
//     final amtController = TextEditingController(
//       text: booking.amount.toString(),
//     );
//     DateTime selectedDate = booking.date;

//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: Text('Edit Booking'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: hallController,
//                   decoration: InputDecoration(labelText: 'Hall Name'),
//                 ),
//                 TextField(
//                   controller: amtController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: 'Amount'),
//                 ),
//                 SizedBox(height: 12),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final updatedBooking = Booking(
//                       id: booking.id,
//                       customerId: booking.customerId,
//                       date: selectedDate,
//                       hallName: hallController.text.trim(),
//                       amount: double.tryParse(amtController.text.trim()) ?? 0,
//                     );
//                     await ref
//                         .read(bookingServiceProvider)
//                         .updateBooking(updatedBooking);
//                     Navigator.pop(context);
//                     ref.invalidate(bookingListProvider);
//                   },
//                   child: Text("Update"),
//                 ),
//               ],
//             ),
//           ),
//     );
//   }

//   void _confirmDelete(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: Text("Confirm Delete"),
//             content: Text("Are you sure you want to delete this booking?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(ctx).pop(),
//                 child: Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   await ref
//                       .read(bookingServiceProvider)
//                       .deleteBooking(booking.id);
//                   Navigator.of(ctx).pop();
//                   ref.invalidate(bookingListProvider);
//                 },
//                 child: Text("Delete", style: TextStyle(color: Colors.red)),
//               ),
//             ],
//           ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:testprojectsix/models/booking_model.dart';
import 'package:testprojectsix/providers/booking_provider.dart';

class BookingCard extends ConsumerWidget {
  final Booking booking;
  final VoidCallback onStatusChanged;
  final VoidCallback onDeleted;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onStatusChanged,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(userRoleProvider).valueOrNull == 'admin';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.hallName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (isAdmin)
                  Text(
                    booking.customerName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Date: ${DateFormat('MMM dd, yyyy').format(booking.date)}'),
            Text('Amount: ₹${booking.amount.toStringAsFixed(2)}'),
            Text('Guests: ${booking.guests}'),
            Row(
              children: [
                const Text('Status: '),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    booking.status.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            if (isAdmin || booking.status == 'pending')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isAdmin && booking.status != 'confirmed')
                    TextButton(
                      onPressed: () => _updateStatus(context, ref, 'confirmed'),
                      child: const Text('Confirm'),
                    ),
                  if (isAdmin && booking.status != 'cancelled')
                    TextButton(
                      onPressed: () => _updateStatus(context, ref, 'cancelled'),
                      child: const Text('Cancel'),
                    ),
                  if (isAdmin)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteBooking(context, ref),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Future<void> _updateStatus(
    BuildContext context,
    WidgetRef ref,
    String status,
  ) async {
    try {
      await ref
          .read(bookingServiceProvider)
          .updateBookingStatus(booking.id, status);
      onStatusChanged();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking ${status} successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  Future<void> _deleteBooking(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Booking'),
            content: const Text(
              'Are you sure you want to delete this booking?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await ref.read(bookingServiceProvider).deleteBooking(booking.id);
        onDeleted();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking deleted successfully!')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
        }
      }
    }
  }
}
