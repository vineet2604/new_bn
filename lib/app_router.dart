// //import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'screens/customer/customer_dashboard.dart';
// import 'screens/login/login_screen.dart';
// import 'screens/home/home_screen.dart';
// import 'screens/bookings/booking_screen.dart';
// //import 'screens/login/login_screen.dart';
// import 'screens/payments/payment_screen.dart';

// class AppRouter {
//   static final GoRouter router = GoRouter(
//     routes: [
//       GoRoute(path: '/', builder: (context, state) => LoginScreen()),
//       GoRoute(path: '/home', builder: (context, state) => HomeScreenPage()),
//       GoRoute(path: '/bookings', builder: (context, state) => BookingsScreen()),
//       // GoRoute(
//       //   path: '/search',
//       //   builder: (context, state) => SearchBookingScreen(),
//       // ),
//       // GoRoute(path: '/finder', builder: (context, state) => FinderScreen()),
//       GoRoute(path: '/payments', builder: (context, state) => PaymentScreen()),
//       GoRoute(
//         path: '/customer',
//         builder: (context, state) => CustomerDashboard(uid: ''),
//       ),
//     ],
//   );
// }
import 'package:go_router/go_router.dart';
import 'package:testprojectsix/screens/login/login_screen.dart';
import 'package:testprojectsix/screens/admin/admin_dashboard_screen.dart';
import 'package:testprojectsix/screens/home/home_screen.dart';
import 'package:testprojectsix/screens/registration/registration_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/admin',
      builder: (context, state) => AdminDashboardScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreenPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationScreen(),
    ),
  ],
);
