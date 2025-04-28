// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../services/auth_service.dart';

// final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
//   return AuthNotifier();
// });

// class AuthNotifier extends StateNotifier<bool> {
//   AuthNotifier() : super(false);

//   Future<void> signIn(String email, String password) async {
//     state = await AuthService().signIn(email, password);
//   }

//   Future<void> signOut() async {
//     await AuthService().signOut();
//     state = false;
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser);

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    state = FirebaseAuth.instance.currentUser;
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return; // Cancelled

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    state = FirebaseAuth.instance.currentUser;
  }
}
