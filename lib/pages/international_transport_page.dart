import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';

class InternationalTransportPage extends StatelessWidget {
  const InternationalTransportPage({super.key});

  static const destinations = <_InternationalDestination>[
    _InternationalDestination(
      country: 'Nigeria',
      city: 'Lagos',
      flagAsset: 'assets/nigeria.png',
      companies: 'STM International, Rimbo International',
      averageFare: 18000,
    ),
    _InternationalDestination(
      country: 'Nigeria',
      city: 'Kano',
      flagAsset: 'assets/nigeria.png',
      companies: 'Rimbo International, AZAWAD Transport',
      averageFare: 11000,
    ),
    _InternationalDestination(
      country: 'Nigeria',
      city: 'Sokoto',
      flagAsset: 'assets/nigeria.png',
      companies: 'Rimbo International',
      averageFare: 10500,
    ),
    _InternationalDestination(
      country: 'Benin',
      city: 'Cotonou',
      flagAsset: 'assets/benin.png',
      companies: 'Rimbo International, STM International',
      averageFare: 12000,
    ),
    _InternationalDestination(
      country: 'Benin',
      city: 'Parakou',
      flagAsset: 'assets/benin.png',
      companies: 'Rimbo International',
      averageFare: 9800,
    ),
    _InternationalDestination(
      country: 'Burkina Faso',
      city: 'Ouagadougou',
      flagAsset: 'assets/burkina-faso.png',
      companies: 'STM International, Rimbo International',
      averageFare: 13500,
    ),
    _InternationalDestination(
      country: 'Burkina Faso',
      city: 'Bobo-Dioulasso',
      flagAsset: 'assets/burkina-faso.png',
      companies: 'STM International',
      averageFare: 14500,
    ),
    _InternationalDestination(
      country: 'Mali',
      city: 'Bamako',
      flagAsset: 'assets/mali.png',
      companies: 'AZAWAD Transport, STM International',
      averageFare: 19500,
    ),
    _InternationalDestination(
      country: 'Mali',
      city: 'Gao',
      flagAsset: 'assets/mali.png',
      companies: 'AZAWAD Transport',
      averageFare: 17500,
    ),
    _InternationalDestination(
      country: 'Algerie',
      city: 'Tamanrasset',
      flagAsset: 'assets/algerie.png',
      companies: 'AZAWAD Transport',
      averageFare: 26000,
    ),
    _InternationalDestination(
      country: 'Tchad',
      city: 'N\'Djamena',
      flagAsset: 'assets/tchad.png',
      companies: 'Rimbo International',
      averageFare: 22500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transport International')),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            final destination = destinations[index];
            return _InternationalDestinationCard(destination: destination);
          },
        ),
      ),
    );
  }
}

class _InternationalDestinationCard extends StatelessWidget {
  final _InternationalDestination destination;

  const _InternationalDestinationCard({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                destination.flagAsset,
                width: double.infinity,
                height: 74,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              destination.city,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              destination.country,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 6),
            Text(
              destination.companies,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0B2E4E),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${destination.averageFare} FCFA',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InternationalDestination {
  final String country;
  final String city;
  final String flagAsset;
  final String companies;
  final int averageFare;

  const _InternationalDestination({
    required this.country,
    required this.city,
    required this.flagAsset,
    required this.companies,
    required this.averageFare,
  });
}
