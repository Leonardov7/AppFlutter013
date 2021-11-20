import 'package:flutter/material.dart';
import 'RegistroUsuario.dart';

class GestionUsuario extends StatefulWidget {
  @override
  GestionUsuarioApp createState() => GestionUsuarioApp();
}

class GestionUsuarioApp extends State<GestionUsuario> {
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Cambio de contraseña"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Dar de baja de la app"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                  child: Text("Modificar usuario "),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20, right: 20, bottom: 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
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
}
