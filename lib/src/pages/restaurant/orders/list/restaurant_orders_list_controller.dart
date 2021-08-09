import 'package:flutter/material.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class RestaurantOrdersListController {
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Future? init(BuildContext context) {
    this.context = context;
  }

  logout() {
    _sharedPref.logout(context);
  }

  void openDrawer(){
    key.currentState!.openDrawer();
  }
}
