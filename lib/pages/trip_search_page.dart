import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/company.dart';
import '../models/trip.dart';
import 'ticket_page.dart';

class TripSearchPage extends StatefulWidget {
  const TripSearchPage({super.key});

  @override
  State<TripSearchPage> createState() => _TripSearchPageState();
}

class _TripSearchPageState extends State<TripSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final results = AppData.trips.where((trip) {
      if (query.isEmpty) {
        return true;
      }
      return trip.from.toLowerCase().contains(query) ||
          trip.to.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Recherche de trajets')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Ex: Niamey, Maradi, Zinder...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              _query = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFE5ECF5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFE5ECF5)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: results.isEmpty
                  ? const Center(
                      child: Text('Aucun trajet trouve pour cette ville.'),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                      itemCount: results.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final trip = results[index];
                        final company = AppData.companies.firstWhere(
                          (c) => c.name == trip.companyName,
                          orElse: () => AppData.companies.first,
                        );
                        return _TripResultCard(trip: trip, company: company);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripResultCard extends StatelessWidget {
  final Trip trip;
  final Company company;

  const _TripResultCard({required this.trip, required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TicketPage(company: company, trip: trip),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFEAF1FB),
                child: Icon(Icons.route),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${trip.from} -> ${trip.to}'),
                    Text(
                      '${trip.companyName} - ${trip.duration} - ${trip.distanceKm} km',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${trip.price.toStringAsFixed(0)} FCFA',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketPage(company: company, trip: trip),
                    ),
                  );
                },
                child: const Text('Reserver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
