import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarritoCompras extends StatefulWidget{
  final String idUser;
  CarritoCompras(this.idUser);
  @override
  CarritoComprasApp createState() => CarritoComprasApp();
}

class CarritoComprasApp extends State<CarritoCompras>{
  TextEditingController cant=TextEditingController();

  final firebase=FirebaseFirestore.instance;


  borrarDocumento(String idItem) async{
    try{
      await firebase.collection("Carrito").doc(idItem).delete();
    }catch(e){
      print(e);
    }


  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),

      ),body: Container(
      child: Center(
        child: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("Carrito").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  if(snapshot.data!.docs[index].get("UsuarioId")==widget.idUser){
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
                                              .get("NombreItem"),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            .get("PrecioItem"),
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
                                    child: TextField(

                                      controller: cant,


                                    )
                                ),
                                FloatingActionButton(
                                  onPressed: (){
                                    mensaje("Borrado","¿Desea borrar el artículo?",snapshot.data!.docs[index].id);
                                  },
                                  //child: Text ("-"),
                                  heroTag: null,
                                  child: const Icon(Icons.remove),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }else{
                    return new Card();
                  }

                });
          },
        ),
      ),
    ),

    );
  }
  void mensaje(String titulo,String mess,String idItem){
    showDialog(context: context, builder: (builcontex){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mess),
        actions: [
          RaisedButton(onPressed: (){
            //Navigator.of(context,rootNavigator: true).pop();// pendiente corregir

          },
            child: Text("Cancelar",
              style: TextStyle(color:Colors.teal),),
          ),
          RaisedButton(onPressed: () async {
            await borrarDocumento(idItem);
          //  Navigator.of(context).pop();
          },
            child: Text("Aceptar",
              style: TextStyle(color:Colors.teal),),
          ),
        ],
      );
    });
  }
}