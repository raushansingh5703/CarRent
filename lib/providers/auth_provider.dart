import 'package:flutter/material.dart';

import '../data/local/pref_service.dart';

class AuthProvider extends ChangeNotifier {
  String? email;

  Future<void> loadUser() async {
    email = await PrefService.getUser();
    notifyListeners();
  }

  bool get isLoggedIn => email != null;

  Future<void> setUser(String e) async {
    email = e;
    await PrefService.saveUser(e);
    notifyListeners();
  }

  Future<void> logout() async {
    await PrefService.logout();
    email = null;
    notifyListeners();
  }
}
