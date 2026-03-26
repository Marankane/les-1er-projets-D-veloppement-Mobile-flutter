import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/trip.dart';

class FavoritesStore extends ChangeNotifier {
  FavoritesStore._();

  static final FavoritesStore instance = FavoritesStore._();
  static const _storageKey = 'favorite_trips_v1';

  final Set<String> _favoriteIds = <String>{};
  final Map<String, Trip> _favoriteTrips = <String, Trip>{};
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs?.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return;
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    _favoriteIds.clear();
    _favoriteTrips.clear();

    for (final entry in decoded) {
      final trip = Trip.fromMap(Map<String, dynamic>.from(entry as Map));
      final id = tripId(trip);
      _favoriteIds.add(id);
      _favoriteTrips[id] = trip;
    }
  }

  String tripId(Trip trip) {
    return '${trip.companyName}-${trip.from}-${trip.to}-${trip.time}';
  }

  bool isFavorite(Trip trip) => _favoriteIds.contains(tripId(trip));

  void toggle(Trip trip) {
    final id = tripId(trip);
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
      _favoriteTrips.remove(id);
    } else {
      _favoriteIds.add(id);
      _favoriteTrips[id] = trip;
    }
    _save();
    notifyListeners();
  }

  void remove(Trip trip) {
    final id = tripId(trip);
    if (_favoriteIds.remove(id)) {
      _favoriteTrips.remove(id);
      _save();
      notifyListeners();
    }
  }

  List<Trip> get favoriteTrips => _favoriteTrips.values.toList(growable: false);

  double get totalPrice {
    return _favoriteTrips.values.fold<double>(
      0,
      (sum, trip) => sum + trip.price,
    );
  }

  Future<void> _save() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final payload = _favoriteTrips.values.map((trip) => trip.toMap()).toList();
    await prefs.setString(_storageKey, jsonEncode(payload));
  }
}
