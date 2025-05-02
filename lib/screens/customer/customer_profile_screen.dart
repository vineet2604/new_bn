// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CustomerProfileScreen extends StatefulWidget {
//   const CustomerProfileScreen({super.key});

//   @override
//   State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
// }

// class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
//   final user = FirebaseAuth.instance.currentUser;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   bool isEditing = false;
//   bool isLoading = true;

//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadProfileData();
//   }

//   Future<void> _loadProfileData() async {
//     if (user == null) return;

//     final doc = await firestore.collection('customers').doc(user!.uid).get();

//     if (doc.exists) {
//       final data = doc.data();
//       _phoneController.text = data?['phone'] ?? '';
//       _addressController.text = data?['address'] ?? '';
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> _saveProfileData() async {
//     if (user == null) return;

//     await firestore.collection('customers').doc(user!.uid).set({
//       'phone': _phoneController.text.trim(),
//       'address': _addressController.text.trim(),
//     }, SetOptions(merge: true));

//     setState(() {
//       isEditing = false;
//     });
//   }

//   void _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, '/login');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           IconButton(
//             icon: Icon(isEditing ? Icons.save : Icons.edit),
//             onPressed: () {
//               if (isEditing) {
//                 _saveProfileData();
//               } else {
//                 setState(() {
//                   isEditing = true;
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 60,
//                       backgroundImage: const AssetImage('assets/images/dp.jpg'),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       user?.displayName ?? 'VINEET GAJJAR',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       user?.email ?? 'email@example.com',
//                       style: const TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     const Divider(height: 32),
//                     _buildEditableField('Phone Number', _phoneController),
//                     const SizedBox(height: 12),
//                     _buildEditableField('Address', _addressController),
//                     const Spacer(),
//                     ElevatedButton.icon(
//                       onPressed: _logout,
//                       icon: const Icon(Icons.logout),
//                       label: const Text('Logout'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//     );
//   }

//   Widget _buildEditableField(String label, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       enabled: isEditing,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         prefixIcon:
//             label.contains('Phone')
//                 ? const Icon(Icons.phone)
//                 : const Icon(Icons.home),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isEditing = false;
  bool isLoading = true;
  bool isLoggingOut = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    if (user == null) return;

    try {
      final doc = await firestore.collection('customers').doc(user!.uid).get();

      if (doc.exists) {
        final data = doc.data();
        _phoneController.text = data?['phone'] ?? '';
        _addressController.text = data?['address'] ?? '';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error loading profile: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _saveProfileData() async {
    if (user == null) return;

    try {
      await firestore.collection('customers').doc(user!.uid).set({
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
      }, SetOptions(merge: true));

      Fluttertoast.showToast(msg: 'Profile updated successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error saving profile: ${e.toString()}');
    }

    if (mounted) {
      setState(() {
        isEditing = false;
      });
    }
  }

  Future<void> _logout() async {
    if (isLoggingOut) return;

    setState(() {
      isLoggingOut = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: 'Logout failed: ${e.toString()}');
        setState(() {
          isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _saveProfileData();
              } else {
                setState(() {
                  isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: const AssetImage('assets/images/dp.jpg'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.displayName ?? 'VINEET GAJJAR',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? 'email@example.com',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const Divider(height: 32),
                    _buildEditableField('Phone Number', _phoneController),
                    const SizedBox(height: 12),
                    _buildEditableField('Address', _addressController),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: isLoggingOut ? null : _logout,
                      icon:
                          isLoggingOut
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Icon(Icons.logout),
                      label: Text(isLoggingOut ? 'Logging out...' : 'Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon:
            label.contains('Phone')
                ? const Icon(Icons.phone)
                : const Icon(Icons.home),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
