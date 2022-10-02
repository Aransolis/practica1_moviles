import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica1/screens/databaseuser_helper.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController txtconNombre = TextEditingController();
  TextEditingController txtconCorreo = TextEditingController();
  TextEditingController txtconTelefono = TextEditingController();
  TextEditingController txtconpagina = TextEditingController();
  DatabaseHelper? _database;
  bool ban = false;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Error al escoger imagen:  $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    
    final txtNombre = TextField(
      controller: txtconNombre,
      decoration: InputDecoration(
        hintText: 'Introduce nombre completo ',
        label: Text('Nombre'),
      ),
      //onChanged: (value){},
    );
    final txtcorreo = TextField(
      controller: txtconCorreo,
      decoration:
          InputDecoration(hintText: 'Introduce correo ', label: Text('Correo')),
    );

    final txtTelefono = TextField(
      controller: txtconTelefono,
      decoration: InputDecoration(
          hintText: 'Introduce telefono', label: Text('Telefono')),
    );

    final txtpagina = TextField(
      controller: txtconpagina,
      decoration: InputDecoration(
          hintText: 'Introdue URL Github ', label: Text('GitHub')),
    );

    final btnGuardar = ElevatedButton(
    onPressed: (){
    
    _database!.insertar({
      'imagen': image.toString(),
      'nombre': txtconNombre.text,
      'correo': txtconCorreo.text,
      'numero': txtconTelefono.text,
      'urlGit': txtconpagina.text
      }, 'tblUser').then((value) {
        final snackBar = SnackBar(content: Text('Usuario registrado correctamente'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    

    Navigator.pop(context);

  }, child: Text('Guardar'),
  );
  

    return Scaffold(
       resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
      Hero(
        tag: 'logoH',
        child: Container(
          child: Padding(
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS9Jzsiid_lhvTpN0KZ_Dkv9yXDSrsnt7Zlg&usqp=CAU'),
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
          ),
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
          physics: BouncingScrollPhysics(),
          children: [
            txtNombre,
            SizedBox(
              height: 15,
            ),
            txtcorreo,
            SizedBox(
              height: 15,
            ),
            txtTelefono,
            SizedBox(
              height: 15,
            ),
            txtpagina,
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text('Escoger imagen desde galeria',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () {
                pickImage();
              },
            ),
           
            btnGuardar


          ],
        ),
      ),
    ]));
  }
}
