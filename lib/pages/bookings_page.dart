import 'package:flutter/material.dart';

import '../state/booking_store.dart';
import '../state/favorites_store.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesStore = FavoritesStore.instance;
    final bookingStore = BookingStore.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Favoris et reservations')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedBuilder(
          animation: Listenable.merge([favoritesStore, bookingStore]),
          builder: (context, _) {
            final favorites = favoritesStore.favoriteTrips;
            final bookings = bookingStore.bookings;

            if (favorites.isEmpty && bookings.isEmpty) {
              return Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.bookmark_border,
                          size: 40,
                          color: Color(0xFF8092AA),
                        ),
                        SizedBox(height: 8),
                        Text('Aucun favori ou reservation enregistree.'),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (bookings.isNotEmpty) ...[
                        Text(
                          'Mes reservations',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        ...bookings.map(
                          (booking) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.companyName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text('${booking.from} -> ${booking.to}'),
                                    Text(
                                      '${booking.date} - ${booking.time} - Place ${booking.seat}',
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Statut: ${booking.status}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Prix: ${booking.price.toStringAsFixed(0)} FCFA',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (favorites.isNotEmpty) ...[
                        Text(
                          'Mes favoris',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        ...favorites.map(
                          (trip) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trip.companyName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text('${trip.from} -> ${trip.to}'),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Prix: ${trip.price.toStringAsFixed(0)} FCFA',
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        onPressed: () =>
                                            favoritesStore.remove(trip),
                                        icon: const Icon(Icons.delete_outline),
                                        label: const Text(
                                          'Retirer des favoris',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B2E4E),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Favoris: ${favoritesStore.totalPrice.toStringAsFixed(0)} FCFA  |  Reservations: ${bookingStore.totalReservedPrice.toStringAsFixed(0)} FCFA',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
