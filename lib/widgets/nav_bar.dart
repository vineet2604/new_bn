// import 'package:flutter/material.dart';
// import 'package:testprojectsix/screens/customer/customer_profile_screen.dart';

// class NavDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Text(
//               'UserName',
//               style: TextStyle(color: Colors.black, fontSize: 25),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: AssetImage('assets/images/bg.jpg'),
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//             onTap: () => {Navigator.of(context).pop()},
//           ),
//           ListTile(
//             leading: Icon(Icons.manage_accounts),
//             title: Text('Profile'),
//             onTap:
//                 () => {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CustomerProfileScreen(),
//                     ),
//                   ),
//                 },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () => {Navigator.of(context).pop()},
//           ),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: Text('Logout'),
//             onTap: () => {Navigator.of(context).pop()},
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Add this import if using GoRouter
import 'package:testprojectsix/screens/customer/customer_profile_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'UserName',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/bg.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/home'); // Adjust the route as needed
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              GoRouter.of(context).go('/profile'); // Navigate to profile
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(
                context,
              ).go('/settings'); // Adjust the route as needed
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/logout'); // Adjust the route as needed
            },
          ),
        ],
      ),
    );
  }
}
