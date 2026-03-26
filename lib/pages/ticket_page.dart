import 'package:flutter/material.dart';

import '../models/company.dart';
import '../models/trip.dart';
import '../state/booking_store.dart';
import '../widgets/app_bottom_nav.dart';

class TicketPage extends StatelessWidget {
  final Company company;
  final Trip trip;

  const TicketPage({super.key, required this.company, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmation')),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      _Line(text: 'Trajet: ${trip.from} -> ${trip.to}'),
                      _Line(text: 'Depart: ${trip.time}'),
                      _Line(text: 'Duree: ${trip.duration}'),
                      _Line(text: 'Distance: ${trip.distanceKm} km'),
                      const Divider(height: 22),
                      Text(
                        'Total: ${trip.price.toStringAsFixed(0)} FCFA',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    BookingStore.instance.addReservationFromTrip(trip);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reservation confirmee et enregistree.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Confirmer le billet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final String text;

  const _Line({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text),
    );
  }
}
