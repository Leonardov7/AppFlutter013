import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CambioPass extends StatefulWidget{
  @override
  CambioPassApp createState() => CambioPassApp();
}

class CambioPassApp extends State<CambioPass>{
TextEditingController correo=TextEditingController();
TextEditingController passA=TextEditingController();
TextEditingController passN=TextEditingController();
final firebase= FirebaseFirestore.instance;
  validarDatos() async{
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario= await ref.get();

      if(usuario.docs.length !=0){
        int flag=0;
        for(var cursor in usuario.docs){
          //print(cursor.get("Correo"));
          if(cursor.get("Correo")==correo.text){
            // print("Correo encotrado");
            if (cursor.get("Contraseña")==passA.text){
              print("usuario_encontrado");
              flag=1;
              print(cursor.id);
              try {
                await firebase
                    .collection("Usuarios")
                    .doc(cursor.id)
                    .set({
                  "Nombre":cursor.get("Nombre"),
                  "Direccion":cursor.get("Direccion"),
                  "Telefono":cursor.get("Telefono"),
                  "Correo":correo.text,
                  "Contraseña":passN.text,
                  "Estado":true
                });
                mensaje("Correcto","Registro correto");
              } catch (e) {
                print(e);
                mensaje("Error...",""+e.toString());
              }
              //Navigator.push(context,
               //   MaterialPageRoute(builder: (_) => busqueda()));
            }
          }
        }//fin de for
        if (flag==0){
          mensaje("Login","Usuario NO encontrado");
        }
      }else{
        print("Collección vacía");
      }
    }catch (e){

    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Cambio de contraseña"),
      ),body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                child: Image.asset('image/login.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: TextField(
              controller: correo,
              decoration: InputDecoration(
                  labelText: "Correo",
                  hintText: "Digite correo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: TextField(
              controller: passA,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Contraseña actual",
                  hintText: "Digite Contraseña actual",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: TextField(
               controller: passN,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Contraseña nueva",
                  hintText: "Digite Contraseña nueva",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 45)),
              onPressed: () {
                validarDatos();
              },
              child: Text("Cambiar"),
            ),
          ),
        ],
      ),
    ),
    );
  }

  void mensaje(String titulo,String mess){
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