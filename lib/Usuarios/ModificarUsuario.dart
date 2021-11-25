import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModificarUsuario extends StatefulWidget {
  @override
  ModificarUsuarioApp createState() => ModificarUsuarioApp();
}

class ModificarUsuarioApp extends State<ModificarUsuario> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController nombre = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  String docId="";
  String password="";
  String CorreoI="";
  bool estado=false;
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
              flag=1;
              nombre.text=cursor.get("Nombre");
              direccion.text=cursor.get("Direccion");
              telefono.text=cursor.get("Telefono");
              this.docId=cursor.id;
              this.CorreoI=cursor.get("Correo");
              this.password=cursor.get("Contraseña");
              this.estado=cursor.get("Estado");
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


 modificarUsuario() async {
    try {
      await firebase
          .collection("Usuarios")
          .doc(docId)
          .set({
        "Nombre":nombre.text,
        "Direccion":direccion.text,
        "Telefono":telefono.text,
        "Correo":this.CorreoI,
        "Contraseña":this.password,
        "Estado":this.estado
      });
      mensaje("Correcto","Registro correto");
    } catch (e) {
      print(e);
      mensaje("Error...",""+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar usuario"),
      ),body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
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
          ),Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Digite contraseña",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(500, 45)),
              onPressed: () {
                validarDatos();
              },
              child: Text("Buscar"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: TextField(
              controller: nombre,
              decoration: InputDecoration(
                  labelText: "Nombre",
                  hintText: "Digite el nombre del usuario",
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
                  hintText: "Digite el dirección del usuario",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
            child: TextField(
              controller: telefono,
              decoration: InputDecoration(
                  labelText: "Teléfono",
                  hintText: "Digite teléfono",
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
                modificarUsuario();
                nombre.clear();
                direccion.clear();
                telefono.clear();
                correo.clear();
                pass.clear();

              },
              child: Text("Modificar"),
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


}
