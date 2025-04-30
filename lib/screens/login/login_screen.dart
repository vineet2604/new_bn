// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:testprojectsix/screens/customer/customer_profile_screen.dart';
// //import 'package:testprojectsix/screens/home/home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _errorMessage = '';

//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = '';
//       });
//       try {
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );
//         // If login is successful, the app should navigate to the next screen
//         // (e.g., the BookingsScreen). You'll likely want to use a Navigator
//         // here. For example:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerProfileScreen()),
//         );
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = _handleAuthError(e.code);
//         });
//       } catch (e) {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'An unexpected error occurred.';
//         });
//         print('Login error: $e');
//       } finally {
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//         }
//       }
//     }
//   }

//   String _handleAuthError(String errorCode) {
//     switch (errorCode) {
//       case 'user-not-found':
//         return 'No user found with this email.';
//       case 'wrong-password':
//         return 'Wrong password provided for this user.';
//       case 'invalid-email':
//         return 'The email address is not valid.';
//       case 'user-disabled':
//         return 'The user account has been disabled.';
//       default:
//         return 'An error occurred during login. Please try again.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!value.contains('@')) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24.0),
//                 if (_errorMessage.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: Text(
//                       _errorMessage,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _login,
//                   child:
//                       _isLoading
//                           ? const CircularProgressIndicator()
//                           : const Text('Login'),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to the registration screen if you have one
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => RegistrationScreen()),
//                     // );
//                     print('Navigate to registration');
//                   },
//                   child: const Text('Don\'t have an account? Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testprojectsix/screens/home/home_screen.dart';
import '../admin/admin_dashboard_screen.dart';
import '../home/signup/signup_page.dart';
import '../customer/customer_dashboard.dart';
import 'package:testprojectsix/screens/customer/customer_profile_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

Future<void> login() async {
  setState(() {
    isLoading = true;
    errorMessage = '';
  });

  try {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final userEmail = userCredential.user?.email;

    if (userEmail == "admin@gmail.com") {
      // Redirect to Admin Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardScreen()), // Replace with your actual admin dashboard widget
      );
    } else {
      // Redirect to Customer Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerDashboard()), // Replace with your actual customer dashboard widget
      );
    }

  } on FirebaseAuthException catch (e) {
    setState(() {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'invalid-email':
          errorMessage = 'Email is invalid.';
          break;
        default:
          errorMessage = 'Login failed: ${e.message}';
      }
    });
  } catch (e) {
    setState(() {
      errorMessage = 'Unexpected error: $e';
    });
  } finally {
    setState(() => isLoading = false);
  }
}

      isLoading = true;
      errorMessage = '';
    });

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      debugPrint("Logged in as: ${userCredential.user?.email}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'invalid-email':
            errorMessage = 'Email is invalid.';
            break;
          default:
            errorMessage = 'Login failed: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Unexpected error: $e';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void goToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(height: 24),

              // Login Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Email Field
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Error Message
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),

                      const SizedBox(height: 10),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child:
                              isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 16),
                                  ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: goToSignUp,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(color: Colors.blueAccent),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

