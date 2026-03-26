import 'package:flutter/material.dart';

class PracticalInfoPage extends StatelessWidget {
  const PracticalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Informations pratiques'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.white,
              child: const TabBar(
                isScrollable: true,
                labelColor: Color(0xFF0B2E4E),
                unselectedLabelColor: Color(0xFF6E8098),
                indicatorColor: Color(0xFF0B2E4E),
                tabs: [
                  Tab(text: 'Documents'),
                  Tab(text: 'Bagages'),
                  Tab(text: 'Securite'),
                  Tab(text: 'Gares Niamey'),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF9FBFF), Color(0xFFEFF5FD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const TabBarView(
            children: [
              _DocumentsTab(),
              _BaggageTab(),
              _SecurityTab(),
              _StationsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentsTab extends StatelessWidget {
  const _DocumentsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoTile(
          icon: Icons.badge_outlined,
          title: 'Transport national',
          content: 'CNI en cours de validite recommandee pour embarquer.',
        ),
        _InfoTile(
          icon: Icons.public,
          title: 'Transport international',
          content:
              'Passeport valide obligatoire. Selon la destination, visa et carnet de vaccination peuvent etre demandes.',
        ),
        _InfoTile(
          icon: Icons.assignment_outlined,
          title: 'Conseil utile',
          content:
              'Conservez une copie numerique de vos documents sur votre telephone.',
        ),
      ],
    );
  }
}

class _BaggageTab extends StatelessWidget {
  const _BaggageTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoTile(
          icon: Icons.luggage,
          title: 'Poids autorise',
          content:
              'Bagage en soute: 20 a 25 kg selon la compagnie. Bagage cabine: 5 a 10 kg.',
        ),
        _InfoTile(
          icon: Icons.straighten,
          title: 'Dimensions conseillees',
          content:
              'Cabine: environ 55 x 35 x 25 cm. Les colis volumineux sont factures en supplement.',
        ),
        _InfoTile(
          icon: Icons.warning_amber_outlined,
          title: 'Objets interdits',
          content:
              'Produits inflammables, objets dangereux et marchandises illicites.',
        ),
      ],
    );
  }
}

class _SecurityTab extends StatelessWidget {
  const _SecurityTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoTile(
          icon: Icons.access_time,
          title: 'Arrivez en avance',
          content: 'Presentez-vous 30 a 45 minutes avant le depart.',
        ),
        _InfoTile(
          icon: Icons.lock_outline,
          title: 'Protection des biens',
          content:
              'Gardez vos objets de valeur en cabine et verifiez vos etiquettes bagages.',
        ),
        _InfoTile(
          icon: Icons.phone_in_talk_outlined,
          title: 'Contacts de confiance',
          content: 'Partagez votre itineraire avec un proche avant le depart.',
        ),
      ],
    );
  }
}

class _StationsTab extends StatelessWidget {
  const _StationsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoTile(
          icon: Icons.place_outlined,
          title: 'Gare de la Riviera (Niamey)',
          content:
              'Point de depart pour plusieurs lignes nationales vers Maradi et Zinder.',
        ),
        _InfoTile(
          icon: Icons.place_outlined,
          title: 'Gare de Yantala (Niamey)',
          content: 'Depart de lignes interurbaines et regionales.',
        ),
        _InfoTile(
          icon: Icons.place_outlined,
          title: 'Gare de Katako (Niamey)',
          content:
              'Zone active pour les liaisons locales et certaines lignes longue distance.',
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEAF1FB),
          child: Icon(icon, color: const Color(0xFF0B2E4E)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(content),
        ),
      ),
    );
  }
}
