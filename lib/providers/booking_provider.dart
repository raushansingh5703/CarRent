import 'package:flutter/material.dart';

import '../data/local/db_helper.dart';

class BookingProvider extends ChangeNotifier {
  List<Map<String, dynamic>> bookings = [];

  Future<void> loadBookings(String email) async {
    bookings = await DBHelper.getBookings(email);
    notifyListeners();
  }

  Future<void> addBooking(Map<String, dynamic> data) async {
    await DBHelper.addBooking(data);
    notifyListeners();
  }
}
