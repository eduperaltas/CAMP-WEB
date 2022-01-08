import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Cursos/AdministradorCrearCurso.dart';
import 'package:camp_web/UI/Screens/ADMIN/Talleres%20y%20Eventos/AdministradorCrearTalleres.dart';
import 'package:camp_web/UI/Screens/ADMIN/Cuponera/AdministradorCuponeraPage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Cursos/AdministradorCursosPage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Usuarios/AdministradorHomePage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Informacion/AdministradorInformacionPage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Publicaciones/AdministradorPublicacionesPage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Suscripcion/AdministradorSuscriptionPage.dart';
import 'package:camp_web/UI/Screens/ADMIN/Talleres%20y%20Eventos/AdministradorTalleresPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdmLateralBar extends StatefulWidget {
  AdmLateralBar();

  @override
  _AdmLateralBarState createState() => _AdmLateralBarState();
}

class _AdmLateralBarState extends State<AdmLateralBar> {

  Widget option(String page){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return Column(
     children: [
       MouseRegion(
         cursor: SystemMouseCursors.click,
         child: GestureDetector(
           onTap: (){
             _ADMPageProvider.changePage(page);
           },
           child: Container(
               width: MediaQuery.of(context).size.width*0.15,
               height: MediaQuery.of(context).size.width*0.04,
               decoration: BoxDecoration(
                 color: _ADMPageProvider.Gpage==page?Color(0Xff2056a1):
                 (_ADMPageProvider.Gpage=='Crear Curso' &&page=='Cursos')?Color(0Xff2056a1):
                 (_ADMPageProvider.Gpage=='Crear Taller' &&page=='Talleres y eventos')?Color(0Xff2056a1)
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
                     color: _ADMPageProvider.Gpage==page?Colors.white:
                     (_ADMPageProvider.Gpage=='Crear Curso' &&page=='Cursos')?Colors.white:
                     (_ADMPageProvider.Gpage=='Crear Taller' &&page=='Talleres y eventos')?Colors.white
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

  Widget LateralBar(){
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.09,
            height: MediaQuery.of(context).size.width*0.09,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0Xff2056a1),
                width: 1,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/Logo - Camp.png")
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),
          option('Usuarios'),
          option('Suscripcion'),
          option('Publicaciones'),
          option('Talleres y eventos'),
          option('Cursos'),
          option('Cuponera'),
          option('Informacion'),
        ],
      ),
    );
  }

  contenido(){
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return _ADMPageProvider.Gpage=='Usuarios'?AdministradorHomePage():
           _ADMPageProvider.Gpage=='Suscripcion'?AdministradorSuscripcionPage():
           _ADMPageProvider.Gpage=='Publicaciones'?AdministradorPublicacionesPage():
           _ADMPageProvider.Gpage=='Talleres y eventos'?AdministradorTalleresPage():
           _ADMPageProvider.Gpage=='Crear Taller'?AdministradorCrearTalleresPage():
           _ADMPageProvider.Gpage=='Cursos'?AdministradorCursosPage():
           _ADMPageProvider.Gpage=='Crear Curso'?AdministradorCrearCursosPage():
           _ADMPageProvider.Gpage=='Cuponera'?AdministradorCuponeraPage():
           _ADMPageProvider.Gpage=='Informacion'?AdministradorInformacionPage():
           Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LateralBar(),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height,
            child: contenido(),
          ),
        ],
      ),
      ),
    );
  }
}
