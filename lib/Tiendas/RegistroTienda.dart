import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroTienda extends StatefulWidget {
  @override
  RegistroTiendaApp createState() => RegistroTiendaApp();
}

class RegistroTiendaApp extends State<RegistroTienda> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController nombreTienda = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController nfoto = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController descrip = TextEditingController();

  registroTienda() async {
    try {
      await firebase
          .collection("Tiendas")
          .doc()
          .set({
        "nombreTienda":nombreTienda.text,
        "Direccion":direccion.text,
        "rutaFoto":nfoto.text,
        "website":website.text,
        "descripcion":descrip.text,
        "estado":true
      });
          
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de tiendas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: nombreTienda,
                decoration: InputDecoration(
                    labelText: "Nombre de la tienda",
                    hintText: "Digite el nombre de la tienda",
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
                    hintText: "Digite el dirección de la tienda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: nfoto,
                decoration: InputDecoration(
                    labelText: "Nombre foto",
                    hintText: "Digite dirección foto",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: website,
                decoration: InputDecoration(
                    labelText: "Página web",
                    hintText: "Digite website de la tienda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: descrip,
                decoration: InputDecoration(
                    labelText: "Descripción",
                    hintText: "Digite descripción de la tienda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    registroTienda();
                    nombreTienda.clear();
                    direccion.clear();
                    nfoto.clear();
                    website.clear();
                    descrip.clear();

                  },
                  child: Text("Registrar"),
                )),
          ],
        ),
      ),
    );
  }
}
