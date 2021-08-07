import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/response_api.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/provider/users_provider.dart';
import 'package:xona_eats/src/utils/my_snackbar.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class LoginController {
  late BuildContext context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    if (user.sessionToken != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'client/products/list', (route) => false);
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi? responseApi = await usersProvider.login(email, password);
    if (responseApi!.success!) {
      print(responseApi.toJson());
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      print('Usuario logueado: ${user.toJson()}');
      if (user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles![0].route!, (route) => false);
      }

    } else {
      MySnackbar.show(context, responseApi.message!);
    }
    print('Response: ${responseApi.toJson()}');
    MySnackbar.show(context, responseApi.message!);
  }
}
