import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
  return await AuthService().getCurrentUser();
});
