import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appmovil13/Productos/RegistroProducto.dart';

class ShopOne extends StatefulWidget {
  final String docId;
  ShopOne(this.docId);
  @override
  ShopOneApp createState() => ShopOneApp();
}

class ShopOneApp extends State<ShopOne> {
  final firebase = FirebaseFirestore.instance;
  String logo = "";
  String titulo = "";
  //String idTienda="";
  String descripcion = "";
  int cont = 0;
  ShopOneApp() {
    buscarDoc();
  }

  buscarDoc() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Tiendas");
      QuerySnapshot tienda = await ref.get();

      if (tienda.docs.length != 0) {
        for (var cursor in tienda.docs) {
          if (cursor.id == widget.docId) {
            this.logo = cursor.get("rutaFoto");
            this.titulo = cursor.get("nombreTienda");

            print(widget.docId + " id importado");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  agregarCarrito() async {

    try {
      await firebase.collection("Carrito").doc("DocId").set({
        "UsuarioId": "PEPITO",
        "ProductoId" + cont.toString(): widget.docId,
        "conteo": cont + 1,
        "Estado": true
      });
      // mensaje1("Correcto","Registro correto");
    } catch (e) {
      print(e);
      // mensaje("Error...",""+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.docId);
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  this.descripcion,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Teléfono'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.web, 'WebSite'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: titulo,
      home: Scaffold(
          appBar: AppBar(
            title: Text(titulo),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'image/' + this.logo,
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    titleSection,
                    buttonSection,
                    textSection,
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Productos",
                        style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    RegistroProducto(widget.docId)));
                      },
                      //child: const Icon(Icons.add_box),
                      child: Text("add"),
                      tooltip: "Agregar producto",
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Productos")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.docs[index].get("IdTienda") ==
                            widget.docId) {
                          return new Card(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        /*1*/
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            /*2*/
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    .get("Nombre"),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  .get("Descripcion"),
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*3*/
                                      Container(
                                        width: 70,
                                        height: 70,
                                        child: Image.asset(
                                          "image/" +
                                              snapshot.data!.docs[index]
                                                  .get("imagen"),
                                        ),
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          agregarCarrito();
                                        },
                                        child:
                                            const Icon(Icons.add_shopping_cart),
                                        tooltip: "Agregar al carrito",
                                        backgroundColor: Colors.blue,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {

                                        },
                                        //child: const Icon(Icons.add_shopping_cart),
                                        child: Text("Ver"),
                                        tooltip: "Agregar al carrito",
                                        backgroundColor: Colors.blue,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        } // fin if
                        else {
                          return new Card();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
