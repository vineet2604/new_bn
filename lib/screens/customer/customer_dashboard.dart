// import 'package:flutter/material.dart';
// import '../../widgets/stat_card.dart';
// import 'customer_profile_screen.dart'; // Add this import

// class CustomerDashboard extends StatelessWidget {
//   const CustomerDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.person),
//             tooltip: 'My Profile',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CustomerProfileScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: const [
//               StatCard(label: 'Booked', count: 0, color: Colors.green),
//               StatCard(label: 'Collection', count: 0, color: Colors.blue),
//               StatCard(label: 'Cancelled', count: 0, color: Colors.orange),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Future: navigate to insights or details
//               },
//               child: Text("Insights"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDashboard extends StatelessWidget {
  final String uid;

  const CustomerDashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Dashboard")),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('customers').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          var userData = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome, ${userData['name']}"),
                Text("Email: ${userData['email']}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
