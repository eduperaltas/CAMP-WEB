import 'dart:js';

import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/model/Evento.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'AdministradorCrearTalleres.dart';
import 'AdministradorCuponeraPage.dart';
import 'AdministradorCursosPage.dart';
import 'AdministradorHomePage.dart';
import 'AdministradorInformacionPage.dart';
import 'AdministradorPublicacionesPage.dart';
import 'AdministradorSuscriptionPage.dart';
import '../Calendar.dart';
import '../CuponeraView.dart';
import '../Mensajes_Buzon.dart';
import '../MuralView.dart';
import '../TalleresEventos.dart';
import '../TalleresEventosDetail.dart';
import '../login.dart';



class AdministradorTalleresPage extends StatefulWidget {
  @override
  _AdministradorTalleresPage createState() => _AdministradorTalleresPage();
}

class _AdministradorTalleresPage extends State<AdministradorTalleresPage> {

  Evento _evento;
  String textolargo="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  Widget Taller(Evento e,BuildContext context){
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.03,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.width*0.15,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(e.portada)
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width*0.08,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(/*e.texto*/textolargo+textolargo,style:TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.008,
                        color: Colors.black,
                        height: 1.5
                    ),
                      textAlign: TextAlign.justify,
                      ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: TalleresEventosVIewDetail(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            child: Text(e.titulo,textAlign: TextAlign.justify, style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width*0.013,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),),
                          ),
                        ),
                        SizedBox(
                          width:MediaQuery.of(context).size.width*0.1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.07,
                          child: Column(
                            children: [
                              Text("Fecha: ${e.fecha.split(' ')[0]}",style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.width*0.008,
                                  color: Colors.black
                              ),),
                              Text("Hora: ${e.fecha.split(' ')[1]} ${e.fecha.split(' ')[2]}",style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.width*0.008,
                                  color: Colors.black
                              ),),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
        SizedBox(
          height:MediaQuery.of(context).size.height*0.05,
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.79,
          height: MediaQuery.of(context).size.height*0.001,
          color: Colors.black,
        ),  
      ],
    );
  }
  
  Widget Contenido(){
    return StreamBuilder(
        stream: FirestoreAPI().eventossData,
        builder: (context, snapshot) {
          List<Evento> lstTalleres=snapshot.data;
          if(!snapshot.hasData){
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*0.8,
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Color(0Xff2056a1),)),
              ),
            );
          }
          if(lstTalleres.length>0)
            return Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.7,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lstTalleres.length,
                  itemBuilder: (context, i){
                    return Taller(lstTalleres[i],context);
                  }
              ),
            );
          else
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*1,
              child: Center(child: Text('No hay cursos para mostrar.'),),);

        }
        );
  }
  
  @override
  Widget build(BuildContext context) {
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.001,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width*0.79,
                height: MediaQuery.of(context).size.height*1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.2,
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Center(
                            child: Text("Talleres y eventos",style: TextStyle(
                              fontSize:MediaQuery.of(context).size.width*0.018,
                              fontWeight: FontWeight.w900,
                            ),),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: (){  _ADMPageProvider.changePage('Crear Taller');  },
                            child:Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.1,
                              child: Center(
                                child: Text("Crear taller o Evento",style: TextStyle(
                                  fontSize:MediaQuery.of(context).size.width*0.018,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0Xff2056a1),
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Contenido()
                  ],
                ),
              ),
            ),
          ],
        ),
    );}
}