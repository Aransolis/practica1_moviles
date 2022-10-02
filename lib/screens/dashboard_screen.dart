// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practica1/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 46, 95, 174),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://c.wallhere.com/photos/00/76/Leo_Messi_soccer-5698.jpg!d'),
                    fit: BoxFit.cover),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addUser');
                },
                child: Hero(
                  tag: 'logoH',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS9Jzsiid_lhvTpN0KZ_Dkv9yXDSrsnt7Zlg&usqp=CAU'),
                  ),
                ),
              ),
              accountName: Text(
                'Aran Solis Medina',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
              ),
              accountEmail: Text('18030151@itcelaya.edu.mx'),
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Practica 1'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Base de datos'),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/task', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Popular Movies'),
              onTap: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/list', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.setBool('login', true);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
      body: ThemeScreen(),
    );
  }
}
