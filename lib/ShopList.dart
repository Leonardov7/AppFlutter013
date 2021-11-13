import 'package:flutter/material.dart';

class ShopList extends StatefulWidget {
  @override
  ShopListApp createState() => ShopListApp();
}

class ShopListApp extends State<ShopList> {
  @override
  String texto1="Comidas rápidas el Gordo --";
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(15),
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
                    texto1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'las mejores comidas del barrio',
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
           child: Image.asset("image/comida-rapida.png"),
         ),
         ElevatedButton(onPressed: (){}, child: Text("Entrar"))
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tiendas"),
      ),
      body: ListView(
        children: [
          titleSection,
          titleSection
        ],
      ),
    );
  }
}
