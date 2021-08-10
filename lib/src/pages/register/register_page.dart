import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:xona_eats/src/pages/register/register_controller.dart';
import 'package:xona_eats/src/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -90,
              child: _circleRegister(),
            ),
            Positioned(
              top: 65.0,
              left: 27.0,
              child: _textRegister(),
            ),
            Positioned(
              top: 51.0,
              left: -5.0,
              child: _iconBack(),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 150.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _textFieldEmail(),
                    _textFieldName(),
                    _textFieldLastName(),
                    _textFieldPhone(),
                    _textFieldPassword(),
                    _textFieldConfirmPassword(),
                    _buttonRegister(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleRegister() => Container(
        width: 240.0,
        height: 230.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), color: MyColors.primaryColor),
      );

  Widget _iconBack() => IconButton(
        onPressed: _con.back,
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      );

  Widget _textRegister() => Text(
        'REGISTRO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          fontFamily: 'NimbusSans',
        ),
      );

  Widget _imageUser() => GestureDetector(
        onTap: _con.showAlertDialog,
        child: CircleAvatar(
          backgroundImage: _con.imageFile != null
              ? FileImage(_con.imageFile!)
              : AssetImage('assets/img/user_profile_2.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.grey[200],
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

  Widget _textFieldName() => Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _con.nameController,
          decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      );

  Widget _textFieldLastName() => Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _con.lastnameController,
          decoration: InputDecoration(
            hintText: 'Apellidos',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      );

  Widget _textFieldPhone() => Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _con.phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.phone,
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

  Widget _textFieldConfirmPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _con.confirmPasswordController,
          decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: MyColors.primaryColor,
            ),
          ),
          obscureText: true,
        ),
      );

  Widget _buttonRegister() => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
        child: ElevatedButton(
          onPressed: _con.register,
          child: Text('Registrarse'),
          style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
        ),
      );

  void refresh() {
    setState(() {});
  }
}
