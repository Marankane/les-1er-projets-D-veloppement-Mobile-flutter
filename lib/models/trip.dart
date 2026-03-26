class Trip {
  final String companyName;
  final String from;
  final String to;
  final String time;
  final String duration;
  final int distanceKm;
  final double price;
  final bool isClimatise;

  const Trip({
    required this.companyName,
    required this.from,
    required this.to,
    required this.time,
    required this.duration,
    required this.distanceKm,
    required this.price,
    required this.isClimatise,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'from': from,
      'to': to,
      'time': time,
      'duration': duration,
      'distanceKm': distanceKm,
      'price': price,
      'isClimatise': isClimatise,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      companyName: map['companyName'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      time: map['time'] as String,
      duration: map['duration'] as String,
      distanceKm: (map['distanceKm'] as num).toInt(),
      price: (map['price'] as num).toDouble(),
      isClimatise: map['isClimatise'] as bool,
    );
  }
}
