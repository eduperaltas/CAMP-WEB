import 'package:camp_web/model/Anuncio.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:camp_web/repository/firebase_auth_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class AdministradorCrearAnunciosPage extends StatefulWidget {
  @override
  _AdministradorCrearAnunciosPage createState() => _AdministradorCrearAnunciosPage();
}

class _AdministradorCrearAnunciosPage extends State<AdministradorCrearAnunciosPage> {
  String _titulo;
  String _text;
  Anuncio anu;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        "Mis anuncios",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0Xff2056a1),
                            fontSize: MediaQuery.of(context).size.height*0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Crear Anuncio",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height*0.02,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Título del anuncio",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height*0.02
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02, top:MediaQuery.of(context).size.height*0.002 ),
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        fillColor: Color(0XFFf8f8ff),
                        hintText: "Título del anuncio",
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.015,
                          //fontFamily:
                        ),
                      ),

                      validator: (input)=> input.isEmpty ? 'Ingresa un título válido' : null,
                      onChanged: (val){
                        setState(() => _titulo = val);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Row(
                  children: [

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Información del anuncio",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height*0.02
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02, top:MediaQuery.of(context).size.height*0.002 ),
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Infomración del anuncio",
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.015,
                          //fontFamily:
                        ),
                      ),
                      validator: (input)=> input.isEmpty ? 'Ingresa un correo válido' : null,
                      onChanged: (val){
                        setState(() => _text = val);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                            if(_text!=null && _titulo!=null)
                              anu= new Anuncio( Autorid: uid, titulo: _titulo,
                                  texto: _text, fechaInicio: 'fechaInicio',
                                  fechaFin: 'fechaFin', estado: 'Activo');
                              FirestoreAPI().createAnuncioData(anu);
                        },
                        child: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width*0.15,
                            height: MediaQuery.of(context).size.height*0.04,
                            decoration: BoxDecoration(
                                color: Color(0Xff2056a1),
                                shape: BoxShape.rectangle
                            ),
                            child: Center(
                              child: Text("Publicar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width*0.01
                                ),),
                            )
                        ),
                      ),
                    ),
                  ],),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
              ],
            ),
          )
        ],
      ),
    );}
}