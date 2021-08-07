import 'package:flutter/material.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class ClientProductListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) {
    this.context = context;
  }

  logout() {
    _sharedPref.logout(context);
  }
}
