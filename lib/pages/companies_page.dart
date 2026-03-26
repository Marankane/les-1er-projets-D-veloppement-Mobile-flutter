import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/company.dart';
import '../widgets/app_bottom_nav.dart';
import 'company_details.dart';

enum TransportType { national, international }

class CompaniesPage extends StatelessWidget {
  final TransportType transportType;

  const CompaniesPage({super.key, this.transportType = TransportType.national});

  @override
  Widget build(BuildContext context) {
    final isNational = transportType == TransportType.national;
    final companies = AppData.companies.where((company) {
      if (isNational) {
        return company.category == 'National';
      }
      return company.category == 'International';
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNational ? 'Compagnies Nationales' : 'Compagnies Internationales',
        ),
      ),
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
          itemCount: companies.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final company = companies[index];
            return _CompanyCard(company: company);
          },
        ),
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  final Company company;

  const _CompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CompanyDetails(company: company)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF4FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    company.logo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.directions_bus, size: 34),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _StaticStars(rating: company.rating),
                        const SizedBox(width: 6),
                        Text(
                          'Note ${company.rating.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      company.vehicleType,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaticStars extends StatelessWidget {
  final double rating;

  const _StaticStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 18);
        }
        if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 18);
        }
        return const Icon(Icons.star_border, color: Colors.amber, size: 18);
      }),
    );
  }
}
