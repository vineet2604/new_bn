import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current week's Monday
  DateTime getStartOfWeek() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    final weekStart = getStartOfWeek();

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAdvancePaymentsCard(),
            SizedBox(height: 16),
            _buildWeeklyBookingsCard(weekStart),
            SizedBox(height: 16),
            _buildBookingMessagesCard(),
            SizedBox(height: 16),
            _buildFoodMenusCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancePaymentsCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advance Payments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('bookings').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final bookings = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final data = bookings[index];
                    return ListTile(
                      title: Text('Customer ID: ${data['customerId']}'),
                      // subtitle: Text(
                      //   'Paid: ₹${data['advancepayment'] ?? 'N/A'}',
                      // ),
                      // subtitle: Text('Paid: ₹${data['advancePayment']}'),
                      trailing: Text(
                        DateFormat(
                          'dd MMM',
                        ).format(data['bookingDate'].toDate()),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyBookingsCard(DateTime weekStart) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Bookings Per Banquet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream:
                  _firestore
                      .collection('bookings')
                      .where('bookingDate', isGreaterThanOrEqualTo: weekStart)
                      .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final bookings = snapshot.data!.docs;

                // Count bookings per banquet
                Map<String, int> banquetCounts = {};
                for (var doc in bookings) {
                  final banquetId = doc['banquetId'];
                  banquetCounts[banquetId] =
                      (banquetCounts[banquetId] ?? 0) + 1;
                }

                return Column(
                  children:
                      banquetCounts.entries.map((entry) {
                        return ListTile(
                          title: Text('Banquet ID: ${entry.key}'),
                          trailing: Text('${entry.value} bookings'),
                        );
                      }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingMessagesCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Messages',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('bookings').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final bookings = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final data = bookings[index];
                    return ListTile(
                      title: Text('Customer ID: ${data['customerId']}'),
                      subtitle: Text(data['message'] ?? 'No message'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodMenusCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Food Menus',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('bookings').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final bookings = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final data = bookings[index];
                    List<dynamic> menu = data['foodMenu'] ?? [];
                    return ListTile(
                      title: Text('Customer ID: ${data['customerId']}'),
                      subtitle: Text(menu.join(', ')),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
