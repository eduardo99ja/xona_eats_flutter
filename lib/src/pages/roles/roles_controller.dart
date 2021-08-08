import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class RolesController {

  late BuildContext context;
  late Function refresh;

  late User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    // OBTENER EL USUARIO DE SESION
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

}