import 'package:flutter/material.dart';
import '../../widgets/stat_card.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Dashboard')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              StatCard(label: 'Booked', count: 0, color: Colors.green),
              StatCard(label: 'Collection', count: 0, color: Colors.blue),
              StatCard(label: 'Cancelled', count: 0, color: Colors.orange),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Future: navigate to insights or details
              },
              child: Text("Insights"),
            ),
          ),
        ],
      ),
    );
  }
}
