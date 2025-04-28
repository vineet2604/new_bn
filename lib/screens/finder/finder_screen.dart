import 'package:flutter/material.dart';

class FinderScreen extends StatelessWidget {
  const FinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final halls = [
      'Banquet-1',
      'Banquet-2',
      'Banquet-3',
      'Banquet-4',
      'Banquet-5',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Finder')),
      body: ListView.builder(
        itemCount: halls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(halls[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/sun.png', width: 24),
                SizedBox(width: 8),
                Image.asset('assets/images/night-mode.png', width: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
