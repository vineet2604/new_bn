import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ Add this import
import 'firebase_options.dart'; // ✅ Add this for Firebase config
import 'app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ✅ Initialize Firebase
  );
  runApp(ProviderScope(child: BanquetCRMApp()));
}

class BanquetCRMApp extends StatelessWidget {
  const BanquetCRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Banquet CRM',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
