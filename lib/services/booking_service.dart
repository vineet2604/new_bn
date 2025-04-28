import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';

class BookingService {
  final CollectionReference _bookingsCollection = FirebaseFirestore.instance
      .collection('bookings');

  Future<void> addBooking(Booking booking) async {
    await _bookingsCollection.add(booking.toMap());
  }

  Future<List<Booking>> fetchBookings() async {
    final querySnapshot = await _bookingsCollection.get();
    return querySnapshot.docs
        .map(
          (doc) => Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Future<void> updateBooking(Booking booking) async {
    await _bookingsCollection.doc(booking.id).update(booking.toMap());
  }

  Future<void> deleteBooking(String id) async {
    await _bookingsCollection.doc(id).delete();
  }
}
