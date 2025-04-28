import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';

final bookingListProvider = FutureProvider<List<Booking>>((ref) async {
  return await BookingService().fetchBookings();
});

final bookingServiceProvider = Provider<BookingService>((ref) {
  return BookingService();
});
