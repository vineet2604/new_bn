//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/bookings/booking_screen.dart';

import 'screens/payments/payment_screen.dart';
import 'screens/customer/customer_dashboard.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreenPage()),
      GoRoute(path: '/bookings', builder: (context, state) => BookingsScreen()),
      // GoRoute(
      //   path: '/search',
      //   builder: (context, state) => SearchBookingScreen(),
      // ),
      // GoRoute(path: '/finder', builder: (context, state) => FinderScreen()),
      GoRoute(path: '/payments', builder: (context, state) => PaymentScreen()),
      GoRoute(
        path: '/customer',
        builder: (context, state) => CustomerDashboard(),
      ),
    ],
  );
}
