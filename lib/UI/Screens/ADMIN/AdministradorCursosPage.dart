import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/model/Curso.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


class AdministradorCursosPage extends StatefulWidget {
  @override
  _AdministradorCursosPage createState() => _AdministradorCursosPage();
}

class _AdministradorCursosPage extends State<AdministradorCursosPage> {
  var img;
  @override

  Widget CardCurso(Curso c,BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.18,
          height: MediaQuery.of(context).size.width*0.18,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(c.portada)
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(c.titulo, style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text("Poniente: ${c.poniente}", style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width*0.01,
            fontWeight: FontWeight.w400,
          ),),
        )
      ],
    );
  }

  Widget contenido(BuildContext context){
    return StreamBuilder(
        stream: FirestoreAPI().cursossData,
        builder: (context, snapshot) {
          List<Curso> lstcursos=snapshot.data;
          if(!snapshot.hasData){
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*1,
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Color(0Xff2056a1),)),
              ),
            );
          }
          if(lstcursos.length>0)
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.73
              ),
              itemCount: lstcursos.length,
              itemBuilder: (BuildContext ctxt, int i) {
                return CardCurso(lstcursos[i],context);
              },
            );
          else
            return Container(
              width: MediaQuery.of(context).size.width*0.53,
              height: MediaQuery.of(context).size.height*1,
              child: Center(child: Text('No hay cursos para mostrar.'),),);

      }
    );
  }

  Widget build(BuildContext context) {
    final _ADMPageProvider =
    Provider.of<AdmPageProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AdmLateralBar(),
            Container(
              width: MediaQuery.of(context).size.width*0.001,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width*0.79,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.2,
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Center(
                            child: Text("Cursos",style: TextStyle(
                              fontSize:MediaQuery.of(context).size.width*0.018,
                              fontWeight: FontWeight.w800,
                            ),),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: (){ _ADMPageProvider.changePage('Crear Curso'); },
                            child:Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.1,
                              child: Center(
                                child: Text("Crear Curso",style: TextStyle(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.01,
                    ),
                    contenido(context)
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );}
}