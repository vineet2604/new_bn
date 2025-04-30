// import 'package:flutter/material.dart';

// class FinderScreen extends StatelessWidget {
//   const FinderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final halls = [
//       'Banquet-1',
//       'Banquet-2',
//       'Banquet-3',
//       'Banquet-4',
//       'Banquet-5',
//     ];

//     return Scaffold(
//       appBar: AppBar(title: Text('Finder')),
//       body: ListView.builder(
//         itemCount: halls.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(halls[index]),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset('assets/images/sun.png', width: 35),
//                 SizedBox(width: 8),
//                 Image.asset('assets/images/night-mode.png', width: 35),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FinderScreen extends StatelessWidget {
  const FinderScreen({super.key});

  // Sample banquet availability data for presentation
  final List<Map<String, dynamic>> hallData = const [
    {'name': 'Banquet-1', 'morning': true, 'evening': false},
    {'name': 'Banquet-2', 'morning': false, 'evening': true},
    {'name': 'Banquet-3', 'morning': true, 'evening': true},
    {'name': 'Banquet-4', 'morning': false, 'evening': false},
    {'name': 'Banquet-5', 'morning': true, 'evening': false},
  ];

  void showAvailability(
    BuildContext context,
    String hallName,
    bool isAvailable,
    String timeSlot,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('$hallName'),
            content: Text(
              'Availability for $timeSlot:\n${isAvailable ? '✅ Available' : '❌ Booked'}',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Finder')),
      body: ListView.builder(
        itemCount: hallData.length,
        itemBuilder: (context, index) {
          final hall = hallData[index];

          return ListTile(
            title: Text(hall['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap:
                      () => showAvailability(
                        context,
                        hall['name'],
                        hall['morning'],
                        'Morning',
                      ),
                  child: Image.asset('assets/images/sun.png', width: 35),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap:
                      () => showAvailability(
                        context,
                        hall['name'],
                        hall['evening'],
                        'Evening',
                      ),
                  child: Image.asset('assets/images/night-mode.png', width: 35),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
