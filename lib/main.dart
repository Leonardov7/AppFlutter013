import 'package:flutter/material.dart';
import 'busqueda.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Tiendas/RegistroTienda.dart';
import 'Usuarios/GestionUsuario.dart';
import 'Tiendas/GestionTienda.dart';

//comentario
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Index());
  }
}

class Index extends StatefulWidget {
  @override
  IndexStart createState() => IndexStart();
}

@override
class IndexStart extends State<Index> {
  TextEditingController buscar=TextEditingController();
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AppMovil',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 0),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('image/logo.png'),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 0),
                  child: TextField(
                    controller: buscar,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Búsqueda',
                        hintText: 'Palabra clave de la búsqueda'),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                      onPressed: () {
                        //print("Presionó el botón");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => busqueda(buscar.text)));
                      },
                      child: Text('Buscar'),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                      onPressed: () {
                     //   print("Presionó el botón");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => GestionTienda()));
                      },
                      child: Text('Gestión tiendas'),
                    )
                ),

                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                      onPressed: () {
                        //   print("Presionó el botón");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => GestionUsuario()));
                      },
                      child: Text('Gestion usuario'),
                    )
                ),
              ],
            ),
          ),
        ));
  }
}
