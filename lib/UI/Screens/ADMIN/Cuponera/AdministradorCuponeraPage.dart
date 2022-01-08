import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/model/Cupon.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'AdministradorCrearCupon.dart';


class AdministradorCuponeraPage extends StatefulWidget {
  @override
  _AdministradorCuponeraPage createState() => _AdministradorCuponeraPage();
}

class _AdministradorCuponeraPage extends State<AdministradorCuponeraPage> {

  Cupon cup;
  Widget option(String page,BuildContext context){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (){
              _ADMPageProvider.changeCupPage(page);
            },
            child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.04,
                decoration: BoxDecoration(
                  color: _ADMPageProvider.Gcuppage==page?Color(0Xff2056a1):
                  ((_ADMPageProvider.Gcuppage=='Ver todos los cupones'||_ADMPageProvider.Gcuppage=='edit') && page=='Ver todos los cupones')?Color(0Xff2056a1):
                  (_ADMPageProvider.Gcuppage=='Crear Cupon' && page=='Crear Cupon')?Color(0Xff2056a1)
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
                      color: _ADMPageProvider.Gcuppage==page?Colors.white:
                      ( (_ADMPageProvider.Gcuppage=='Ver todos los cupones'||_ADMPageProvider.Gcuppage=='edit') && page=='Ver todos los cupones')?Colors.white:
                      (_ADMPageProvider.Gcuppage=='Crear Cupon' &&page=='Crear Cupon')?Colors.white
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

  Widget cupon(Cupon c,BuildContext context){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
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
                      child: Text(c.titulo,style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.015,
                          color: Colors.black
                      ),),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          cup=c;
                          _ADMPageProvider.changeCupPage('edit');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          height: MediaQuery.of(context).size.height*0.03,
                          child: Text("Editar",style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width*0.015,
                              fontWeight: FontWeight.w900,
                              color: Colors.black
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.125,
                height: MediaQuery.of(context).size.height*0.03,
                child: Text(c.estado,style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.015,
                    fontWeight: FontWeight.w600,
                    color: c.estado=='Activo'
                        ?Colors.green: Colors.red
                ),),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    FirestoreAPI().ChangeStateCupon(!(c.estado=='Activo'), c.id);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.125,
                    height: MediaQuery.of(context).size.height*0.03,
                    child: Text(c.estado=='Activo'
                        ?'Desactivar':'Activar',style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.015,
                        fontWeight: FontWeight.w900,
                        color: c.estado=='Activo'
                            ?Colors.red: Colors.green
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

  Widget ScreenCupones(BuildContext context){
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirestoreAPI().cuponesData,
        builder: (context, snapshot) {
          List<Cupon> lstcupones=snapshot.data;
          if(!snapshot.hasData){
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*1,
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Color(0Xff2056a1),)),
              ),
            );
          }
          if(lstcupones.length>0){
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for(int x =0; x<lstcupones.length;x++)
                    cupon(lstcupones[x],context),
                ],
              ),
            );
          }
          else
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*1,
              child: Center(child: Text('No hay cupones para mostrar.'),),);

        }
      ),
    );
  }

  contenido(BuildContext context){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return _ADMPageProvider.Gcuppage=='Ver todos los cupones'?ScreenCupones(context):
    _ADMPageProvider.Gcuppage=='Crear Cupon'?AdministradorCrearCuponeraPage(mood: 'crear',):
    _ADMPageProvider.Gcuppage=='edit'?AdministradorCrearCuponeraPage(mood: 'edit',cupEdit: cup,)
        :Container();
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
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Cuponera",style: TextStyle(
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
                      option('Ver todos los cupones', context),
                      option('Crear Cupon', context),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.001,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        contenido(context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );}
}