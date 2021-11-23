import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopList extends StatefulWidget {
  @override
  ShopListApp createState() => ShopListApp();
}

class ShopListApp extends State<ShopList> {
  @override
  String texto1 = "Comidas rápidas el Gordo --";

  /// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tiendas"),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Tiendas").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
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
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .get("nombreTienda"),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                      snapshot.data!.docs[index]
                                          .get("descripcion"),
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
                                  child: Image.asset("image/"+snapshot.data!.docs[index]
                                      .get("rutaFoto"),),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      snapshot.data!.docs[index]
                                          .id;
                                    }, child: Text("Entrar"))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
