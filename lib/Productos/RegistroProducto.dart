import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroProducto extends StatefulWidget {
  final String TiendaId;
  RegistroProducto(this.TiendaId);


  @override
  RegistroProductoApp createState() =>RegistroProductoApp();
}

class RegistroProductoApp extends State<RegistroProducto> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController nombre = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController imagen = TextEditingController();



  registroProducto() async {
    try {
      await firebase
          .collection("Productos")
          .doc()
          .set({
        "Nombre":nombre.text,
        "Precio":precio.text,
        "Descripcion":descripcion.text,
        "imagen":imagen.text,
        "IdTienda":widget.TiendaId,
        "Estado":true
      });
      mensaje1("Correcto","Registro correto");
    } catch (e) {
      print(e);
      mensaje("Error...",""+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de productos"),
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
                    labelText: "Nombre del producto",
                    hintText: "Digite el nombre del producto",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: precio,
                decoration: InputDecoration(
                    labelText: "Precio final",
                    hintText: "Digite precio del producto",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: descripcion,
                decoration: InputDecoration(
                    labelText: "Descripción",
                    hintText: "Digite Descripción corta",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: imagen,
                decoration: InputDecoration(
                    labelText: "Nombre de la imagen",
                    hintText: "Digite ruta de la imagen",
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
                  registroProducto();
                  nombre.clear();
                  precio.clear();
                  descripcion.clear();
                  imagen.clear();
                    },
                child: Text("Registrar"),
              ),
            ),
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
  void mensaje1(String titulo,String mess){
    showDialog(context: context, builder: (builcontex){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mess),
        actions: [
          RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          },
            child: Text("Aceptar",
              style: TextStyle(color:Colors.teal),),
          ),
        ],
      );
    });
  }

}

