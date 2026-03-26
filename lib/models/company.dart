class Company {
  final String name;
  final String logo;
  final double rating;
  final String vehicleType;
  final String description;
  final String services;
  final String phone;
  final List<String> destinations;
  final String category;

  const Company({
    required this.name,
    required this.logo,
    required this.rating,
    required this.vehicleType,
    required this.description,
    required this.services,
    required this.phone,
    required this.destinations,
    this.category = 'National',
  });
}
