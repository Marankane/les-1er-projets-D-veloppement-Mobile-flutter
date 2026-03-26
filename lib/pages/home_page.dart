import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/company.dart';
import 'bookings_page.dart';
import 'companies_page.dart';
import 'company_details.dart';
import 'international_transport_page.dart';
import 'offers_page.dart';
import 'ticket_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _searchButtonOffset = const Offset(16, 460);

  Future<void> _openSearch() async {
    final selectedCompany = await showSearch<Company?>(
      context: context,
      delegate: _CompanySearchDelegate(AppData.companies),
    );

    if (!mounted || selectedCompany == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompanyDetails(company: selectedCompany),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balaguro'),
        leading: const Icon(Icons.directions_bus),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxLeft = (constraints.maxWidth - 170).clamp(
            12.0,
            double.infinity,
          );
          final maxTop = (constraints.maxHeight - 56).clamp(
            12.0,
            double.infinity,
          );
          final currentLeft = _searchButtonOffset.dx.clamp(12.0, maxLeft);
          final currentTop = _searchButtonOffset.dy.clamp(12.0, maxTop);

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset('assets/bus.png', fit: BoxFit.cover),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white.withValues(alpha: 0.86),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.22,
                                  child: Image.asset(
                                    'assets/bus.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bienvenue sur Balaguro',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF0B2E4E),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Choisissez votre espace pour commencer rapidement.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: const Color(0xFF5C6F89),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Transport National',
                      subtitle: 'Voyages entre regions',
                      icon: Icons.map,
                      accent: const Color(0xFF0D8B8B),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CompaniesPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _SectionCard(
                      title: 'Transport International',
                      subtitle: 'Lignes vers les pays limitrophes',
                      icon: Icons.public,
                      accent: const Color(0xFF3E64D8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InternationalTransportPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _SectionCard(
                      title: 'Mes reservations',
                      subtitle: 'Retrouvez vos billets favoris',
                      icon: Icons.bookmark,
                      accent: const Color(0xFFE26B2E),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookingsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    Card(
                      color: Colors.white.withValues(alpha: 0.86),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Offres promotionnelles',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            ...AppData.offers
                                .take(3)
                                .map(
                                  (offer) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: _PromoOfferCard(
                                      title: offer.title,
                                      code: offer.code,
                                      discountPercent: offer.discountPercent,
                                      validity: offer.validity,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const OffersPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      color: Colors.white.withValues(alpha: 0.86),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Trajets populaires',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            ...AppData.trips.take(4).map((trip) {
                              final company = AppData.companies.firstWhere(
                                (c) => c.name == trip.companyName,
                                orElse: () => AppData.companies.first,
                              );
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: _PopularTripCard(
                                  title: '${trip.from} -> ${trip.to}',
                                  subtitle:
                                      '${trip.companyName} - ${trip.duration}',
                                  price:
                                      '${trip.price.toStringAsFixed(0)} FCFA',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TicketPage(
                                          company: company,
                                          trip: trip,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: currentLeft,
                top: currentTop,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _searchButtonOffset = Offset(
                        (_searchButtonOffset.dx + details.delta.dx).clamp(
                          12.0,
                          maxLeft,
                        ),
                        (_searchButtonOffset.dy + details.delta.dy).clamp(
                          12.0,
                          maxTop,
                        ),
                      );
                    });
                  },
                  child: FloatingActionButton.extended(
                    onPressed: _openSearch,
                    icon: const Icon(Icons.search),
                    label: const Text('Rechercher'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withValues(alpha: 0.70),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Color(0xFF61748F)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoOfferCard extends StatelessWidget {
  final String title;
  final String code;
  final int discountPercent;
  final String validity;
  final VoidCallback onTap;

  const _PromoOfferCard({
    required this.title,
    required this.code,
    required this.discountPercent,
    required this.validity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF5FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: Color(0xFF0B2E4E)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text('Code: $code  -$discountPercent%'),
                  Text(validity, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _PopularTripCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;

  const _PopularTripCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.route, color: Color(0xFF0B2E4E)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Text(price, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _CompanySearchDelegate extends SearchDelegate<Company?> {
  final List<Company> companies;

  _CompanySearchDelegate(this.companies);

  List<Company> _filterCompanies(String input) {
    final value = input.trim().toLowerCase();
    if (value.isEmpty) {
      return companies;
    }
    return companies
        .where((company) => company.name.toLowerCase().contains(value))
        .toList();
  }

  @override
  String get searchFieldLabel => 'Rechercher une compagnie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _filterCompanies(query);
    if (results.isEmpty) {
      return const Center(child: Text('Aucune compagnie trouvee.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final company = results[index];
        return ListTile(
          leading: const Icon(Icons.directions_bus),
          title: Text(company.name),
          subtitle: Text(company.category),
          onTap: () => close(context, company),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _filterCompanies(query);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final company = suggestions[index];
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(company.name),
          onTap: () {
            query = company.name;
            showResults(context);
          },
        );
      },
    );
  }
}
