import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../busqueda.dart';
class Login extends StatefulWidget {
  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login> {
  TextEditingController correo=TextEditingController();
  TextEditingController pass=TextEditingController();
  
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
            if (cursor.get("Contraseña")==pass.text){
              print("usuario_encontrado");
              flag=1;
             // Navigator.push(context,MaterialPageRoute(builder: (_) => busqueda()));
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingreso usuario registrado"),
      ),
      body: SingleChildScrollView(
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
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Contraseña",
                    hintText: "Digite Contraseña",
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
                  //correo.text="Hola mundo";
                },
                child: Text("Enviar"),
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
