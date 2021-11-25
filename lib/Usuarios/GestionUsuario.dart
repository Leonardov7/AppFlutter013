import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RegistroUsuario.dart';
import 'Login.dart';
import 'CambioPass.dart';
import 'ModificarUsuario.dart';

class GestionUsuario extends StatefulWidget {
  @override
  GestionUsuarioApp createState() => GestionUsuarioApp();
}

class GestionUsuarioApp extends State<GestionUsuario> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        int flag = 0;
        for (var cursor in usuario.docs) {
          //print(cursor.get("Correo"));
          if (cursor.get("Correo") == correo.text) {
            // print("Correo encotrado");
            if (cursor.get("Contraseña") == pass.text) {
              print("usuario_encontrado");
              flag = 1;
              print(cursor.id);
              try {
                await firebase
                    .collection("Usuarios")
                    .doc(cursor.id)
                    .set({
                  "Nombre": cursor.get("Nombre"),
                  "Direccion": cursor.get("Direccion"),
                  "Telefono": cursor.get("Telefono"),
                  "Correo": cursor.get("Correo"),
                  "Contraseña": cursor.get("Contraseña"),
                  "Estado": false
                });
                mensaje("Correcto", "Registro correto");
              } catch (e) {
                print(e);
                mensaje("Error...", "" + e.toString());
              }
              //Navigator.push(context,
              //   MaterialPageRoute(builder: (_) => busqueda()));
            }
          }
        } //fin de for
        if (flag == 0) {
          mensaje("Inactivación", "Usuario NO encontrado");
        }
      } else {
        print("Collección vacía");
      }
    } catch (e) {
      mensaje("Error...", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion de usuarios"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5, top: 40, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegistroUsuario()));
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Registro Usuario"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CambioPass()));
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Cambio de contraseña"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    inactivar("Inactivar", "Desea inactivar el usuario");
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Dar de baja de la app"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ModificarUsuario()));
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Modificar usuario "),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("LOGIN"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void inactivar(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (builcontex) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
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
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: TextField(
                  controller: pass,
                  decoration: InputDecoration(
                      labelText: "Contraseña",
                      hintText: "Digite Contraseña",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  validarDatos();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  void mensaje(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (builcontex) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          );
        });
  }
}
