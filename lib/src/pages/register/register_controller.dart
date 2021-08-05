import 'package:flutter/material.dart';
import 'package:xona_eats/src/models/response_api.dart';
import 'package:xona_eats/src/models/user.dart';
import 'package:xona_eats/src/provider/users_provider.dart';
import 'package:xona_eats/src/utils/my_snackbar.dart';

class RegisterController {
  BuildContext? context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  Future? init(BuildContext context) {
    this.context = context;
    usersProvider.init(context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    // Validate not empty fields
    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context!, 'Favor de ingresar todos los campos');
      return;
    }
    //Validate passwords match
    if (confirmPassword != password) {
      MySnackbar.show(context!, 'Las contraseñas deben coincidir');
      return;
    }
    //Validate password lenght
    if (password.length < 6) {
      MySnackbar.show(context!, 'La contraseña debe contener al menos 6 caracteres');
      return;
    }
    User user = User(email: email, name: name, lastname: lastname, phone: phone, password: password);

    ResponseApi? responseApi = await usersProvider.create(user);

    MySnackbar.show(context!, responseApi!.message!);
  }
}
