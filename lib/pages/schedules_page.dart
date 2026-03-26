import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../widgets/app_bottom_nav.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horaires')),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: AppData.trips.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final trip = AppData.trips[index];
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFEAF1FB),
                  child: Icon(Icons.schedule),
                ),
                title: Text('${trip.from} -> ${trip.to}'),
                subtitle: Text(
                  '${trip.companyName} - ${trip.time} (${trip.duration})',
                ),
                trailing: Text(
                  '${trip.price.toStringAsFixed(0)} FCFA',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
