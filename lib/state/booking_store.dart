import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_data.dart';
import '../models/booking.dart';
import '../models/trip.dart';

class BookingStore extends ChangeNotifier {
  BookingStore._();

  static final BookingStore instance = BookingStore._();
  static const _storageKey = 'saved_bookings_v1';

  final List<Booking> _bookings = <Booking>[];
  SharedPreferences? _prefs;

  List<Booking> get bookings => List<Booking>.unmodifiable(_bookings);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs?.getString(_storageKey);

    if (raw == null || raw.isEmpty) {
      _bookings
        ..clear()
        ..addAll(AppData.bookings);
      await _save();
      return;
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    _bookings
      ..clear()
      ..addAll(
        decoded.map(
          (entry) => Booking.fromMap(Map<String, dynamic>.from(entry as Map)),
        ),
      );
  }

  void addReservationFromTrip(Trip trip) {
    final booking = Booking(
      companyName: trip.companyName,
      from: trip.from,
      to: trip.to,
      date: _formatDate(DateTime.now()),
      time: trip.time,
      seat: _nextSeat(),
      status: 'Confirme',
      price: trip.price,
    );

    _bookings.insert(0, booking);
    _save();
    notifyListeners();
  }

  double get totalReservedPrice {
    return _bookings.fold<double>(0, (sum, booking) => sum + booking.price);
  }

  String _nextSeat() {
    final number = _bookings.length + 1;
    final row = String.fromCharCode(65 + ((number - 1) % 6));
    final seat = (((number - 1) ~/ 6) + 1).toString().padLeft(2, '0');
    return '$row$seat';
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  Future<void> _save() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final payload = _bookings.map((booking) => booking.toMap()).toList();
    await prefs.setString(_storageKey, jsonEncode(payload));
  }
}
