import 'package:flutter/material.dart';

class SearchBookingScreen extends StatefulWidget {
  const SearchBookingScreen({Key? key}) : super(key: key);

  @override
  _SearchBookingScreenState createState() => _SearchBookingScreenState();
}

class _SearchBookingScreenState extends State<SearchBookingScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allBookings = [
    {"name": "John Doe", "event": "Wedding", "date": "2025-05-20"},
    {"name": "Jane Smith", "event": "Birthday Party", "date": "2025-06-15"},
    {"name": "David Johnson", "event": "Corporate Event", "date": "2025-07-10"},
    {"name": "Sophia Lee", "event": "Engagement", "date": "2025-05-25"},
  ];
  List<Map<String, String>> filteredBookings = [];

  @override
  void initState() {
    super.initState();
    filteredBookings = allBookings;
  }

  void _searchBooking(String query) {
    final results =
        allBookings.where((booking) {
          final nameLower = booking['name']!.toLowerCase();
          final eventLower = booking['event']!.toLowerCase();
          final dateLower = booking['date']!.toLowerCase();
          final searchLower = query.toLowerCase();

          return nameLower.contains(searchLower) ||
              eventLower.contains(searchLower) ||
              dateLower.contains(searchLower);
        }).toList();

    setState(() {
      filteredBookings = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Bookings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchBooking,
              decoration: InputDecoration(
                hintText: 'Search by Name, Event, or Date',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  filteredBookings.isNotEmpty
                      ? ListView.builder(
                        itemCount: filteredBookings.length,
                        itemBuilder: (context, index) {
                          final booking = filteredBookings[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: const Icon(Icons.event_available),
                              title: Text(booking['name']!),
                              subtitle: Text(
                                '${booking['event']} - ${booking['date']}',
                              ),
                            ),
                          );
                        },
                      )
                      : const Center(
                        child: Text(
                          'No bookings found!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
