// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/booking_model.dart';
// import '../services/booking_service.dart';

// final bookingListProvider = FutureProvider<List<Booking>>((ref) async {
//   return await BookingService().fetchBookings();
// });

// final bookingServiceProvider = Provider<BookingService>((ref) {
//   return BookingService();
// });

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testprojectsix/models/booking_model.dart';

final bookingListProvider = StreamProvider<List<Booking>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return const Stream.empty();

  return ref
      .watch(userRoleProvider)
      .when(
        data: (role) {
          try {
            final query =
                role == 'admin'
                    ? firestore
                        .collection('bookings')
                        .orderBy('createdAt', descending: true)
                    : firestore
                        .collection('bookings')
                        .where('customerId', isEqualTo: user.uid)
                        .orderBy('createdAt', descending: true);

            return query.snapshots().map((snapshot) {
              return snapshot.docs
                  .map(
                    (doc) => Booking.fromMap(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    ),
                  )
                  .toList();
            });
          } catch (e) {
            debugPrint('Query error: $e');
            return const Stream.empty();
          }
        },
        loading: () => const Stream.empty(),
        error: (error, stack) => const Stream.empty(),
      );
});

final authStateProvider = Provider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});

final userRoleProvider = FutureProvider<String>((ref) async {
  final user = ref.read(authStateProvider);
  if (user == null) return 'customer';

  final doc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  return doc.data()?['role'] as String? ?? 'customer';
});

final bookingServiceProvider = Provider<BookingService>((ref) {
  return BookingService();
});

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking(Booking booking) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _firestore.collection('bookings').add(booking.toMap());
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': status,
    });
  }

  Future<void> deleteBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).delete();
  }
}
