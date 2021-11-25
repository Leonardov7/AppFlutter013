import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RegistroTienda.dart';
import 'ShopList.dart';

class GestionTienda extends StatefulWidget {
  @override
  GestionTiendaApp createState() => GestionTiendaApp();
}

class GestionTiendaApp extends State<GestionTienda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion Tiendas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40,bottom: 0,left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RegistroTienda()));
                },
                child: Text("Registra tienda"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20,bottom: 0,left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                onPressed: () {},
                child: Text("Modificar Tienda"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20,bottom: 0,left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ShopList()));
                },
                child: Text("Listar tiendas"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
