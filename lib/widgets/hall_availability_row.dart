import 'package:flutter/material.dart';

class HallAvailabilityRow extends StatelessWidget {
  final String hallName;
  final bool isMorningAvailable;
  final bool isEveningAvailable;

  const HallAvailabilityRow({
    super.key,
    required this.hallName,
    required this.isMorningAvailable,
    required this.isEveningAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(hallName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: isMorningAvailable ? 1.0 : 0.3,
            child: Image.asset('assets/sun.png', width: 24),
          ),
          SizedBox(width: 8),
          Opacity(
            opacity: isEveningAvailable ? 1.0 : 0.3,
            child: Image.asset('assets/moon.png', width: 24),
          ),
        ],
      ),
    );
  }
}
