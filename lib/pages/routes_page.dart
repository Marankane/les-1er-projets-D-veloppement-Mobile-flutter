import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/company.dart';
import '../models/trip.dart';
import '../state/favorites_store.dart';
import '../widgets/app_bottom_nav.dart';
import 'ticket_page.dart';

class RoutesPage extends StatelessWidget {
  final Company company;

  const RoutesPage({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final trips = AppData.trips
        .where((trip) => trip.companyName == company.name)
        .toList();
    final favoritesStore = FavoritesStore.instance;

    return Scaffold(
      appBar: AppBar(title: Text('Trajets ${company.name}')),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: trips.isEmpty
            ? const Center(child: Text('Aucun trajet disponible.'))
            : AnimatedBuilder(
                animation: favoritesStore,
                builder: (context, _) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: trips.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return _TripCard(
                        trip: trip,
                        company: company,
                        isFavorite: favoritesStore.isFavorite(trip),
                        onToggleFavorite: () => favoritesStore.toggle(trip),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Trip trip;
  final Company company;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const _TripCard({
    required this.trip,
    required this.company,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${trip.from} -> ${trip.to}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onToggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: [
                _InfoChip(
                  icon: Icons.straighten,
                  text: '${trip.distanceKm} km',
                ),
                _InfoChip(icon: Icons.schedule, text: trip.duration),
                _InfoChip(
                  icon: trip.isClimatise
                      ? Icons.ac_unit
                      : Icons.do_not_disturb_alt,
                  text: trip.isClimatise ? 'Climatise' : 'Non climatise',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Prix: ${trip.price.toStringAsFixed(0)} FCFA',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketPage(company: company, trip: trip),
                    ),
                  );
                },
                icon: const Icon(Icons.confirmation_num_outlined),
                label: const Text('Reserver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF3FB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF0B2E4E)),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
