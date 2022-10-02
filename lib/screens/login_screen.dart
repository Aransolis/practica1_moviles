// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';



class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  
  bool? isChecked = false;



  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
        hintText: 'Introduce el usuario ',
        label: Text('Correo Electronico'),
      ),
      //onChanged: (value){},
    );
    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Introduce el password ', label: Text('Contraseña')),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                'assets/messiLogo.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20,
                bottom: MediaQuery.of(context).size.width / 20,
              ),
              color: Color.fromARGB(255, 255, 253, 253),
              child: ListView(
                shrinkWrap: true,
                children: [
                  txtUser,
                  SizedBox(
                    height: 15,
                  ),
                  txtPwd
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 30,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(context, '/dash');
                },
                child: Image.asset('assets/balon.png',
                    height: MediaQuery.of(context).size.width / 4),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 15,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20),
                //color: Colors.black,
                width: MediaQuery.of(context).size.width/1.0,
                child: Column(
                  //shrinkWrap: true,
                  children: [
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.facebook,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.github,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      //width: double.infinity,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () {},
                    ),
                    CheckboxListTile(
                      value: isChecked, 
                    title: const Text('Guardar Sesión',  
                    style: TextStyle(color: Colors.red,
                     fontSize: 19, fontWeight: 
                     FontWeight.w700),),
                  
                    onChanged: (value) async{
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      setState(()  {
                        isChecked = value!;
                      _prefs.setBool('login', false);
                      });
                    },
                    secondary: const Icon(Icons.safety_check,color: Colors.red, size: 40),
                    
                )
                ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
