import 'dart:js';

import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/model/Publicacion.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'AdministradorPublicacionCrearPublicacion.dart';
import 'AdministradorPublicacionesCrearAnuncio.dart';


class AdministradorPublicacionesPage extends StatefulWidget {
  @override
  _AdministradorPublicacionesPage createState() => _AdministradorPublicacionesPage();
}

class _AdministradorPublicacionesPage extends State<AdministradorPublicacionesPage> {

  String fil='Aprobado';
  Widget option(String page,BuildContext context){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (){
              _ADMPageProvider.changePubPage(page);
            },
            child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.04,
                decoration: BoxDecoration(
                  color: _ADMPageProvider.Gpubpage==page?Color(0Xff2056a1):
                  (_ADMPageProvider.Gpubpage=='Publicaciones de usuarios' &&page=='Publicaciones de usuarios')?Color(0Xff2056a1):
                  (_ADMPageProvider.Gpubpage=='Crear Publicacion' &&page=='Crear Publicacion')?Color(0Xff2056a1):
                  (_ADMPageProvider.Gpubpage=='Crear Anuncio' && page=='Crear Anuncio')?Color(0Xff2056a1)
                      :Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(page, style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width*0.015,
                      color: _ADMPageProvider.Gpubpage==page?Colors.white:
                      (_ADMPageProvider.Gpubpage=='Publicaciones de usuarios' &&page=='Publicaciones de usuarios')?Colors.white:
                      (_ADMPageProvider.Gpubpage=='Crear Publicacion' &&page=='Crear Publicacion')?Colors.white:
                      (_ADMPageProvider.Gpubpage=='Crear Anuncio' &&page=='Crear Anuncio')?Colors.white
                          :Colors.black
                  ),),
                )
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.005,
        ),
      ],
    );
  }

  Widget filtro(String val){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(fil==val?Color(0Xff2056a1):Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(fil==val?Colors.white:Colors.black)
        ),
        onPressed: () {
          setState(() {
            fil=val;
          });
        },
        child: Text(val),
      ),
    );
  }

  Widget RowFiltro(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Mostrar:'),
          filtro('Aprobado'),
          filtro('Pendiente'),
          filtro('Rechazado'),
      ],
    );
  }

  Widget ScreenPublicaciones(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RowFiltro(),
          Container(
            width: MediaQuery.of(context).size.width*0.53,
            height: MediaQuery.of(context).size.height*0.9,
            child: StreamBuilder(
            stream: FirestoreAPI(filtro: fil).publicacionesData,
            builder: (context, snapshot) {
                List<Publicacion> lstPublicaciones=snapshot.data;
                if(!snapshot.hasData){
                  return Center(
                    child: Container(child: CircularProgressIndicator(color: Color(0Xff2056a1),)),
                  );
                }
                if(lstPublicaciones.length>0){
                  print(lstPublicaciones.length.toString());

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lstPublicaciones.length,
                      itemBuilder: (context, i){
                        return publicaion(context,lstPublicaciones[i]);
                      }
                  );
                }
                else
                  return Container(
                    width: MediaQuery.of(context).size.width*0.53,
                    height: MediaQuery.of(context).size.height*1,
                    child: Center(child: Text('No hay publicaciones para mostrar.'),),);

              }),
          ),
        ],
      ),
    );
  }

  Widget publicaion(BuildContext context,Publicacion pub){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.53,
          height: MediaQuery.of(context).size.height*0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                height: MediaQuery.of(context).size.height*0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.25,
                      height: MediaQuery.of(context).size.height*0.03,
                      child: Text(pub.titulo,style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.015,
                          color: Colors.black
                      ),),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.03,
                        child: Text("ver publicación",style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width*0.015,
                            fontWeight: FontWeight.w900,
                            color: Colors.black
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){FirestoreAPI().Pubchangestate(true, pub);},
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.125,
                    height: MediaQuery.of(context).size.height*0.03,
                    child: Text(pub.estado,style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.015,
                        fontWeight: FontWeight.w600,
                        // color: Colors.green
                    ),),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){FirestoreAPI().Pubchangestate(false, pub);},
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.125,
                    height: MediaQuery.of(context).size.height*0.03,
                    child: Text(pub.estado=="Rechazado"?"Aprobar":"Rechazar",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.015,
                        fontWeight: FontWeight.w900,
                        color: pub.estado=="Rechazado"?Colors.green:Colors.red
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.53,
          height: MediaQuery.of(context).size.height*0.001,
          color: Colors.black,
        ),
      ],
    );
  }

  contenido(BuildContext context){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return _ADMPageProvider.Gpubpage=='Publicaciones de usuarios'?ScreenPublicaciones(context):
    _ADMPageProvider.Gpubpage=='Crear Publicacion'?AdministradorCrearPublicacionesPage():
    _ADMPageProvider.Gpubpage=='Crear Anuncio'?AdministradorCrearAnunciosPage():Container();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.001,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.79,
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Publicaciones",style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width*0.018,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.001,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                      ),
                      option('Publicaciones de usuarios',context),
                      option('Crear Publicacion',context),
                      option('Crear Anuncio',context),
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context, PageTransition(child: AdministradorPublicacionesPage(), type: PageTransitionType.rightToLeft));
                      //   },
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width*0.2,
                      //       height: MediaQuery.of(context).size.width*0.04,
                      //       decoration: BoxDecoration(
                      //         color: Color(0Xff2056a1),
                      //         border: Border.all(
                      //           color: Colors.black,
                      //           width: 1,
                      //         ),
                      //       ),
                      //       child: Center(
                      //         child: Text("Publicaciones de usuarios", style: TextStyle(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: MediaQuery.of(context).size.width*0.015,
                      //             color: Colors.white
                      //         ),),
                      //       )
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height*0.005,
                      // ),
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context, PageTransition(child: AdministradorCrearPublicacionesPage(), type: PageTransitionType.rightToLeft));
                      //   },
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width*0.2,
                      //       height: MediaQuery.of(context).size.width*0.04,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         border: Border.all(
                      //           color: Colors.black,
                      //           width: 1,
                      //         ),
                      //       ),
                      //       child: Center(
                      //         child: Text("Crear Publicación", style: TextStyle(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: MediaQuery.of(context).size.width*0.015,
                      //             color: Colors.black
                      //         ),),
                      //       )
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height*0.005,
                      // ),
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context, PageTransition(child: AdministradorCrearAnunciosPage(), type: PageTransitionType.rightToLeft));
                      //   },
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width*0.2,
                      //       height: MediaQuery.of(context).size.width*0.04,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         border: Border.all(
                      //           color: Colors.black,
                      //           width: 1,
                      //         ),
                      //       ),
                      //       child: Center(
                      //         child: Text("Crear Anuncio", style: TextStyle(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: MediaQuery.of(context).size.width*0.015,
                      //             color: Colors.black
                      //         ),),
                      //       )
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.001,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                  ),
                  contenido(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );}
}