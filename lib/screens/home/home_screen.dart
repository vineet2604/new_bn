// import 'package:flutter/material.dart';
// import 'package:testprojectsix/screens/bookings/booking_screen.dart';
// import 'package:testprojectsix/screens/finder/finder_screen.dart';
// import 'package:testprojectsix/screens/home/calender_home_screen.dart';
// //import 'package:testprojectsix/screens/search/search_booking_screen.dart';
// import 'home_screen_page.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int activeScreenIndex = 1; // Default Home

//   final List<Widget> screens = [
//     CalendarScreen(),
//     // SearchBookingScreen(),
//     HomeScreenPage(),
//     BookingsScreen(),
//     FinderScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Image.asset(
//             'assets/images/bg.jpg',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           // Foreground content
//           screens[activeScreenIndex],
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.pink,
//         unselectedItemColor: Colors.amber,
//         currentIndex: activeScreenIndex,
//         onTap: (index) {
//           setState(() {
//             activeScreenIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today, color: Colors.black),
//             label: 'Calendar',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.search, color: Colors.black),
//           //   label: 'Search',
//           // ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.black),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book, color: Colors.black),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search_outlined, color: Colors.black),
//             label: 'Finder',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:testprojectsix/models/booking_model.dart';
import 'package:testprojectsix/screens/bookings/booking_screen.dart';
import 'package:testprojectsix/screens/finder/finder_screen.dart';
import 'package:testprojectsix/screens/home/calender_home_screen.dart';

// Import the screens you have actually created
// Example:
// import 'calendar_screen.dart';
// import 'auditorium_screen.dart';
// import 'finder_screen.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int activeScreenIndex = 1; // Default Home

  final List<Map<String, String>> banquets = [
    {'name': 'Grand Royal Hall', 'image': 'assets/images/royal_banquet.jpg'},
    {
      'name': 'Elegant Bliss Banquet',
      'image': 'assets/images/garden_venue.jpg',
    },
    {'name': 'Sunshine Event Center', 'image': 'assets/images/grand_hall.jpg'},
    {'name': 'Crystal Palace', 'image': 'assets/images/crystal_room.jpg'},
    {'name': 'The Regal Venue', 'image': 'assets/images/open_ground.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Foreground Content (Banquet Grid)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: banquets.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final banquet = banquets[index];
                  return Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.asset(
                              banquet['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            banquet['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.amber,
        currentIndex: activeScreenIndex,
        onTap: (index) {
          if (index == 1) {
            // Home Screen -> already here
            setState(() {
              activeScreenIndex = 1;
            });
          } else if (index == 0) {
            //Calendar Screen -> Navigate if you have created CalendarScreen
            Example:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarScreen()),
            );
          } else if (index == 2) {
            // Auditorium Screen -> Navigate if you have created AuditoriumScreen
            Example:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingsScreen()),
            );
          } else if (index == 3) {
            // Finder Screen -> Navigate if you have created FinderScreen
            Example:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinderScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.black),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.black),
            label: 'Auditorium',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, color: Colors.black),
            label: 'Finder',
          ),
        ],
      ),
    );
  }
}
