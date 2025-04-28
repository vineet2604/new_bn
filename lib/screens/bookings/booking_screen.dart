// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../models/booking_model.dart';
// import '../../providers/booking_provider.dart';
// import '../../widgets/primary_button.dart';
// import 'booking_card.dart';

// class BookingsScreen extends ConsumerWidget {
//   const BookingsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final bookingsAsyncValue = ref.watch(bookingListProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Bookings')),
//       body: bookingsAsyncValue.when(
//         data:
//             (bookings) =>
//                 bookings.isEmpty
//                     ? const Center(child: Text("No bookings available."))
//                     : ListView.builder(
//                       itemCount: bookings.length,
//                       itemBuilder: (context, index) {
//                         final booking = bookings[index];
//                         return BookingCard(booking: booking);
//                       },
//                     ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, st) => Center(child: Text('Error: $e')),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddBookingDialog(context, ref),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void _showAddBookingDialog(BuildContext context, WidgetRef ref) {
//     final hallController = TextEditingController();
//     final amtController = TextEditingController();
//     DateTime selectedDate = DateTime.now();

//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Add Booking'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: hallController,
//                   decoration: const InputDecoration(labelText: 'Hall Name'),
//                 ),
//                 TextField(
//                   controller: amtController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'Amount'),
//                 ),
//                 SizedBox(height: 12),
//                 PrimaryButton(
//                   label: 'Save',
//                   onPressed: () async {
//                     final newBooking = Booking(
//                       id: '',
//                       customerId: 'dummy-user-id',
//                       date: selectedDate,
//                       hallName: hallController.text.trim(),
//                       amount: double.tryParse(amtController.text.trim()) ?? 0,
//                     );
//                     await ref
//                         .read(bookingServiceProvider)
//                         .addBooking(newBooking);
//                     Navigator.pop(context);
//                     ref.invalidate(bookingListProvider);
//                   },
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../models/booking_model.dart';
// import '../../providers/booking_provider.dart';
// import '../../widgets/primary_button.dart';
// import 'booking_card.dart';

// class BookingsScreen extends ConsumerStatefulWidget {
//   const BookingsScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
// }

// class _BookingsScreenState extends ConsumerState<BookingsScreen> {
//   String _searchTerm = '';
//   List<Booking> _filteredBookings = [];

//   @override
//   Widget build(BuildContext context) {
//     final bookingsAsyncValue = ref.watch(bookingListProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bookings'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => _showSearchDialog(context),
//           ),
//         ],
//       ),
//       body: bookingsAsyncValue.when(
//         data: (bookings) {
//           if (_searchTerm.isNotEmpty) {
//             _filteredBookings =
//                 bookings
//                     .where(
//                       (booking) => booking.hallName.toLowerCase().contains(
//                         _searchTerm.toLowerCase(),
//                       ),
//                     )
//                     .toList();
//           } else {
//             _filteredBookings = bookings;
//           }

//           return _filteredBookings.isEmpty
//               ? const Center(child: Text("No bookings available."))
//               : ListView.builder(
//                 itemCount: _filteredBookings.length,
//                 itemBuilder: (context, index) {
//                   final booking = _filteredBookings[index];
//                   return BookingCard(booking: booking);
//                 },
//               );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, st) => Center(child: Text('Error: $e')),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddBookingDialog(context, ref),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void _showSearchDialog(BuildContext context) {
//     final searchController = TextEditingController();
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Search Bookings'),
//             content: TextField(
//               controller: searchController,
//               decoration: const InputDecoration(hintText: 'Enter hall name'),
//               onChanged: (value) {
//                 setState(() {
//                   _searchTerm = value;
//                 });
//               },
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     _searchTerm = '';
//                   });
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Clear'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     _searchTerm = searchController.text.trim();
//                   });
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Search'),
//               ),
//             ],
//           ),
//     );
//   }

//   void _showAddBookingDialog(BuildContext context, WidgetRef ref) {
//     final hallController = TextEditingController();
//     final amtController = TextEditingController();
//     DateTime selectedDate = DateTime.now();

//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Add Booking'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: hallController,
//                   decoration: const InputDecoration(labelText: 'Hall Name'),
//                 ),
//                 TextField(
//                   controller: amtController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'Amount'),
//                 ),
//                 SizedBox(height: 12),
//                 PrimaryButton(
//                   label: 'Save',
//                   onPressed: () async {
//                     final newBooking = Booking(
//                       id: '',
//                       customerId: 'dummy-user-id',
//                       date: selectedDate,
//                       hallName: hallController.text.trim(),
//                       amount: double.tryParse(amtController.text.trim()) ?? 0,
//                     );
//                     await ref
//                         .read(bookingServiceProvider)
//                         .addBooking(newBooking);
//                     Navigator.pop(context);
//                     ref.invalidate(bookingListProvider);
//                   },
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/booking_model.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/primary_button.dart';
import 'booking_card.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen> {
  String _searchTerm = '';
  List<Booking> _filteredBookings = [];

  @override
  Widget build(BuildContext context) {
    final bookingsAsyncValue = ref.watch(bookingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: bookingsAsyncValue.when(
        data: (bookings) {
          if (_searchTerm.isNotEmpty) {
            _filteredBookings =
                bookings
                    .where(
                      (booking) => booking.hallName.toLowerCase().contains(
                        _searchTerm.toLowerCase(),
                      ),
                    )
                    .toList();
          } else {
            _filteredBookings = bookings;
          }

          return _filteredBookings.isEmpty
              ? const Center(child: Text("No bookings available."))
              : ListView.builder(
                itemCount: _filteredBookings.length,
                itemBuilder: (context, index) {
                  final booking = _filteredBookings[index];
                  return BookingCard(booking: booking);
                },
              );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBookingDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Search Bookings'),
            content: TextField(
              controller: searchController,
              decoration: const InputDecoration(hintText: 'Enter hall name'),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchTerm = '';
                  });
                  Navigator.pop(context);
                },
                child: const Text('Clear'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchTerm = searchController.text.trim();
                  });
                  Navigator.pop(context);
                },
                child: const Text('Search'),
              ),
            ],
          ),
    );
  }

  void _showAddBookingDialog(BuildContext context, WidgetRef ref) {
    final hallController = TextEditingController();
    final amtController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Booking'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: hallController,
                  decoration: const InputDecoration(labelText: 'Hall Name'),
                ),
                TextField(
                  controller: amtController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "Date: ${selectedDate.toLocal()}".split(
                        ' ',
                      )[0], // Display the selected date
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed:
                          () => _selectDate(context, selectedDate, (newDate) {
                            setState(() {
                              selectedDate = newDate;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                PrimaryButton(
                  label: 'Save',
                  onPressed: () async {
                    final newBooking = Booking(
                      id: '',
                      customerId: 'dummy-user-id',
                      date: selectedDate,
                      hallName: hallController.text.trim(),
                      amount: double.tryParse(amtController.text.trim()) ?? 0,
                    );
                    await ref
                        .read(bookingServiceProvider)
                        .addBooking(newBooking);
                    Navigator.pop(context);
                    ref.invalidate(bookingListProvider);
                  },
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime currentDate,
    Function(DateTime) onDateSelected,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != currentDate) {
      onDateSelected(picked);
    }
  }
}
