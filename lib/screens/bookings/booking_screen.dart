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
// import 'package:firebase_auth/firebase_auth.dart';
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
//                 Row(
//                   children: [
//                     Text(
//                       "Date: ${selectedDate.toLocal()}".split(
//                         ' ',
//                       )[0], // Display the selected date
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.calendar_today),
//                       onPressed:
//                           () => _selectDate(context, selectedDate, (newDate) {
//                             setState(() {
//                               selectedDate = newDate;
//                             });
//                           }),
//                     ),
//                   ],
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

//   Future<void> _selectDate(
//     BuildContext context,
//     DateTime currentDate,
//     Function(DateTime) onDateSelected,
//   ) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: currentDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != currentDate) {
//       onDateSelected(picked);
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:testprojectsix/models/booking_model.dart';
import 'package:testprojectsix/providers/booking_provider.dart';
import 'package:testprojectsix/widgets/primary_button.dart';
import 'package:testprojectsix/screens/bookings/booking_card.dart';

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
                bookings.where((booking) {
                  return booking.hallName.toLowerCase().contains(
                        _searchTerm.toLowerCase(),
                      ) ||
                      booking.customerName.toLowerCase().contains(
                        _searchTerm.toLowerCase(),
                      );
                }).toList();
          } else {
            _filteredBookings = bookings;
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(bookingListProvider),
            child:
                _filteredBookings.isEmpty
                    ? const Center(child: Text("No bookings available."))
                    : ListView.builder(
                      itemCount: _filteredBookings.length,
                      itemBuilder: (context, index) {
                        final booking = _filteredBookings[index];
                        return BookingCard(
                          booking: booking,
                          onStatusChanged:
                              () => ref.invalidate(bookingListProvider),
                          onDeleted: () => ref.invalidate(bookingListProvider),
                        );
                      },
                    ),
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
    final searchController = TextEditingController(text: _searchTerm);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Search Bookings'),
            content: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search by hall or customer',
              ),
              onChanged: (value) => setState(() => _searchTerm = value),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() => _searchTerm = '');
                  Navigator.pop(context);
                },
                child: const Text('Clear'),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _searchTerm = searchController.text.trim());
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
    final guestsController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Booking'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: hallController,
                    decoration: const InputDecoration(labelText: 'Hall Name'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amtController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: guestsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Number of Guests',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "Date: ${DateFormat('MMM dd, yyyy').format(selectedDate)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed:
                            () => _selectDate(context, selectedDate, (newDate) {
                              setState(() => selectedDate = newDate);
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'Save',
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) return;

                      final newBooking = Booking(
                        id: '',
                        customerId: user.uid,
                        customerName: user.displayName ?? 'Customer',
                        date: selectedDate,
                        hallName: hallController.text.trim(),
                        amount: double.tryParse(amtController.text.trim()) ?? 0,
                        guests: int.tryParse(guestsController.text.trim()) ?? 0,
                        createdAt: DateTime.now(),
                      );

                      try {
                        await ref
                            .read(bookingServiceProvider)
                            .addBooking(newBooking);
                        if (mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking added successfully!'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
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
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != currentDate) {
      onDateSelected(picked);
    }
  }
}
