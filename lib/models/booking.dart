class Booking {
  final String companyName;
  final String from;
  final String to;
  final String date;
  final String time;
  final String seat;
  final String status;
  final double price;

  const Booking({
    required this.companyName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.seat,
    required this.status,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'from': from,
      'to': to,
      'date': date,
      'time': time,
      'seat': seat,
      'status': status,
      'price': price,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      companyName: map['companyName'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      seat: map['seat'] as String,
      status: map['status'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }
}
