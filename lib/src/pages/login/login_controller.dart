import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/response_api.dart';
import 'package:xona_eats/src/provider/users_provider.dart';
import 'package:xona_eats/src/utils/my_snackbar.dart';

class LoginController {
  BuildContext? context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi? responseApi = await usersProvider.login(email, password);
    print('Response: ${responseApi!.toJson()}');
    MySnackbar.show(context!, responseApi.message!);
  }
}
