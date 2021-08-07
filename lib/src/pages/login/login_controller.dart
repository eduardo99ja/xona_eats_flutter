import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/response_api.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/provider/users_provider.dart';
import 'package:xona_eats/src/utils/my_snackbar.dart';
import 'package:xona_eats/src/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    if(user.sessionToken != null){
      Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi? responseApi = await usersProvider.login(email, password);
    if (responseApi!.success!) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      Navigator.pushNamedAndRemoveUntil(
          context!, 'client/products/list', (route) => false);
    } else {
      MySnackbar.show(context!, responseApi.message!);
    }
    print('Response: ${responseApi.toJson()}');
    MySnackbar.show(context!, responseApi.message!);
  }
}
