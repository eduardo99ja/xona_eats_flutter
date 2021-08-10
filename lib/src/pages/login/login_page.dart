import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:xona_eats/src/pages/login/login_controller.dart';

import 'package:xona_eats/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _con = new LoginController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, //Todo el ancho de la pantalla
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              top: 60.0,
              left: 25.0,
              child: _textLogin(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // _imageBanner(),
                  _lottieAnimation(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lottieAnimation() => Container(
        margin: EdgeInsets.only(top: 150.0, bottom: MediaQuery.of(context).size.height * 0.17),
        child: Lottie.asset(
          'assets/json/delivery.json',
          width: 350.0,
          height: 200.0,
          fit: BoxFit.fill,
        ),
      );

  Widget _circleLogin() => Container(
        width: 240.0,
        height: 230.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), color: MyColors.primaryColor),
      );

  Widget _textLogin() => Text(
        'LOGIN',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
          fontFamily: 'NimbusSans',
        ),
      );

  Widget _imageBanner() => Container(
        margin: EdgeInsets.only(top: 100.0, bottom: MediaQuery.of(context).size.height * 0.2),
        child: Image.asset(
          'assets/img/delivery.png',
          width: 200.0,
          height: 200.0,
        ),
      );

  Widget _textFieldEmail() => Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _con.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Correo electrónico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      );

  Widget _textFieldPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _con.passwordController,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            ),
          ),
          obscureText: true,
        ),
      );

  Widget _buttonLogin() => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
        child: ElevatedButton(
          onPressed: _con.login,
          child: Text('Ingresar'),
          style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
        ),
      );

  Widget _textDontHaveAccount() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor,
                fontSize: 17.0
            ),
          ),
          SizedBox(
            width: 7.0,
          ),
          GestureDetector(
            onTap: _con.goToRegisterPage,
            child: Text(
              'Registrate',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
                fontSize: 17.0
              ),
            ),
          ),
        ],
      );
}
