import 'package:appmovil13/Carrito/CarritoCompras.dart';
import 'package:appmovil13/Carrito/Carrtio.dart';
import 'package:appmovil13/Tiendas/ObjetoTienda.dart';
import 'package:appmovil13/Usuarios/Login.dart';
import 'package:appmovil13/Usuarios/Token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appmovil13/Productos/RegistroProducto.dart';

class ShopOne extends StatefulWidget {
  final ObjetoTienda tiendaObj;
  ShopOne(this.tiendaObj);
  @override
  ShopOneApp createState() => ShopOneApp();
}

class ShopOneApp extends State<ShopOne> {
  final firebase = FirebaseFirestore.instance;
  // String logo = "";
  // String titulo = "";
  //String idTienda="";
  // String descripcion = "";
  int cont = 0;
  ShopOneApp() {
    // buscarDoc();
  }

  /* buscarDoc() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Tiendas");
      QuerySnapshot tienda = await ref.get();

      if (tienda.docs.length != 0) {
        for (var cursor in tienda.docs) {
          if (cursor.id == widget.tiendaObj.idTienda) {
          //  this.logo = cursor.get("rutaFoto");
            this.titulo = cursor.get("nombreTienda");

           // print(widget.docId + " id importado");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }*/

  agregarCarrito(Carrito cartShopping) async {
    try {
      await firebase.collection("Carrito").doc().set({
        "UsuarioId": cartShopping.idUser,
        "NombreTienda": cartShopping.nombreTienda,
        "ProductoId": cartShopping.idItem,
        "PrecioItem": cartShopping.precioItem,
        "NombreItem": cartShopping.nombreItem,
        "Descripcion": cartShopping.descripcion,
        "Cantidad":cartShopping.cantidad,
        "Total":cartShopping.total,
      });
      //mensaje("Correcto","Registro correto");
    } catch (e) {
      print(e);
      // mensaje("Error...",""+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.docId);
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
                    widget.tiendaObj.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.tiendaObj.des_corta,
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
      title: widget.tiendaObj.nombre,
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.tiendaObj.nombre),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'image/' + widget.tiendaObj.imagen,
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
                                builder: (_) => RegistroProducto(
                                    widget.tiendaObj.idTienda)));
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
                            widget.tiendaObj.idTienda) {
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
                                        onPressed: () async {
                                          // agregarCarrito();
                                          Token tk = new Token();
                                          String idUser =
                                              await tk.validarToken("");
                                          print(idUser);
                                          Carrito cart = new Carrito();
                                          cart.descripcion = snapshot
                                              .data!.docs[index]
                                              .get("Descripcion");
                                          cart.nombreItem = snapshot
                                              .data!.docs[index]
                                              .get("Nombre");
                                          cart.precioItem = snapshot
                                              .data!.docs[index]
                                              .get("Precio");
                                          cart.idItem =
                                              snapshot.data!.docs[index].id;
                                          cart.nombreTienda =
                                              widget.tiendaObj.nombre;
                                          cart.idUser = idUser;
                                          if (idUser != "") {// si hay sessión activa

                                            mensajeCantidad("Agregar al carrito","¿Desea agregar el artívulo al carrito?",cart);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        CarritoCompras(
                                                            idUser)));
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => Login()));
                                          }
                                        },
                                        child:
                                            const Icon(Icons.add_shopping_cart),
                                        heroTag: null,
                                        tooltip: "Agregar al carrito",
                                        backgroundColor: Colors.blue,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {},
                                        //child: const Icon(Icons.add_shopping_cart),
                                        child: Text("Ver"),
                                        tooltip: "ver producto",
                                        heroTag: null,
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

  void mensajeCantidad(String titulo, String mess, Carrito cart) {
    TextEditingController cant=TextEditingController();

    cant.text="1" ;

    showDialog(
        context: context,
        builder: (builcontex) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: [
              Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: TextField(
                  controller: cant,

                  decoration: InputDecoration(
                      labelText: "Cantidad ",
                      hintText: "Digite Cantidad",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  //Navigator.of(context,rootNavigator: true).pop();// pendiente corregir
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  cart.cantidad=cant.text;
                  cart.total=double.parse(cart.cantidad)*double.parse(cart.precioItem);
                  await  agregarCarrito(cart);
                  //  Navigator.of(context).pop();
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
