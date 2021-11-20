import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroUsuario extends StatefulWidget {
  @override
  RegistroUsuarioApp createState() =>RegistroUsuarioApp();
}

class RegistroUsuarioApp extends State<RegistroUsuario> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController nombre = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();


  registroUsuario() async {
    try {
      await firebase
          .collection("Usuarios")
          .doc()
          .set({
        "Nombre":nombre.text,
        "Direccion":direccion.text,
        "Telefono":telefono.text,
        "Correo":correo.text,
        "Contraseña":pass.text,
        "Estado":true
      });

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Usuarios"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: nombre,
                decoration: InputDecoration(
                    labelText: "Nombre",
                    hintText: "Digite el nombre del usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: direccion,
                decoration: InputDecoration(
                    labelText: "Dirección",
                    hintText: "Digite el dirección del usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: telefono,
                decoration: InputDecoration(
                    labelText: "Teléfono",
                    hintText: "Digite teléfono",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                    labelText: "Correo",
                    hintText: "Digite correo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Contraseña",
                    hintText: "Digite contraseña",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
                padding:
                EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  onPressed: () {
                    registroUsuario();
                    nombre.clear();
                    direccion.clear();
                    telefono.clear();
                    correo.clear();
                    pass.clear();
                  },
                  child: Text("Registrar"),
                )),
          ],
        ),
      ),
    );
  }
  void mensaje(String titulo,String mess ){
    showDialog(
      context:context,
      builder: (builcontext){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mess),
        actions: [
          RaisedButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child:Text("Aceptar",
            style:TextStyle(color:Colors.blueGrey)),
          ),
        ],
      ) ;
      }
    );
  }
}

