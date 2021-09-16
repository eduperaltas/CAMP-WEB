import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';
import 'Calendar.dart';
import 'ComprasOnline.dart';
import 'Contactos.dart';
import 'CuponeraView.dart';
import 'CursosView.dart';
import 'HomeView.dart';
import 'Mensajes_Buzon.dart';
import 'MuralView.dart';
import 'ProfileView.dart';
import 'Publicaciones.dart';
import 'TalleresEventos.dart';
import 'login.dart';



class ContactosDetailView extends StatefulWidget {
  double collapsableHeight = 0.0;
  Color selected = Color(0Xff2056a1);
  Color notSelected = Colors.grey;
  @override
  _ContactosDetailView createState() => _ContactosDetailView();
}

class _ContactosDetailView extends State<ContactosDetailView> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.18),
                  duration: Duration(milliseconds: 375),
                  curve: Curves.ease,
                  height: (width < 800.0) ? collapsableHeight : 0.0,
                  width: double.infinity,
                  //color de contenedor desplegable
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: navBarItems,
                    ),
                  ),
                ),
                Container(
                  color: Color(0xcfffffff),
                  height: MediaQuery.of(context).size.width*0.18,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LayoutBuilder(builder: (context, constraints) {
                        if (width < 800.0) {
                          return Row(

                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                height: MediaQuery.of(context).size.width*0.1,
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
                                width: MediaQuery.of(context).size.width*0.1,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, PageTransition(child: CalendarView(), type: PageTransitionType.rightToLeft));
                                    },
                                    child: Container(
                                      child: Icon(Icons.calendar_today_outlined,color: Color(0Xff2056a1), size: MediaQuery.of(context).size.width*0.03,),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.1,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, PageTransition(child: MensajesView(), type: PageTransitionType.rightToLeft));
                                    },
                                    child: Container(
                                        child: Icon(Icons.mail,color: Color(0Xff2056a1), size: MediaQuery.of(context).size.width*0.03,)
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.1,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, PageTransition(child: LoginView(), type: PageTransitionType.rightToLeft));
                                    },
                                    child: Container(
                                      child:  Icon(Icons.person,color: Color(0Xff2056a1), size: MediaQuery.of(context).size.width*0.03,),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.1,
                              ),
                              NavBarButton(
                                onPressed: () {

                                  if (collapsableHeight == 0.0) {
                                    setState(() {
                                      collapsableHeight = 240.0;
                                    });
                                  } else if (collapsableHeight == 240.0) {
                                    setState(() {
                                      collapsableHeight = 0.0;
                                    });
                                  }
                                },
                              ),

                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.065,
                                    height: MediaQuery.of(context).size.width*0.065,
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
                                    width: MediaQuery.of(context).size.width*0.15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.15,
                                    height: MediaQuery.of(context).size.width*0.025,
                                    decoration: BoxDecoration(
                                      color: Color(0XffEAECEE),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular((20.0))),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: TextFormField(
                                      autocorrect: true,
                                      //textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10, top:MediaQuery.of(context).size.height*0.003),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        prefixIcon: Icon(Icons.search,
                                          color: Colors.black,),
                                        fillColor: Colors.white,
                                        labelStyle: TextStyle(
                                          color: Color(0Xff6c6c6c),
                                          //fontFamily:
                                        ),
                                      ),

                                      validator: (input)=> input.isEmpty ? 'Ingresa un Email válido' : null,
                                      onChanged: (val){
                                        //setState(() => _email = val);
                                      },

                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.15,
                                  ),
                                  Row(
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, PageTransition(child: CalendarView(), type: PageTransitionType.rightToLeft));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*0.018,
                                            height: MediaQuery.of(context).size.width*0.018,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage("assets/images/agenda.png")
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.01,
                                      ),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, PageTransition(child: MensajesView(), type: PageTransitionType.rightToLeft));
                                          },
                                          child: Container(
                                              child: Icon(Icons.mail,color: Color(0Xff2056a1), size: MediaQuery.of(context).size.width*0.02,)
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.01,
                                      ),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, PageTransition(child: LoginView(), type: PageTransitionType.rightToLeft));
                                          },
                                          child: Container(
                                            child:  Icon(Icons.person,color: Color(0Xff2056a1), size: MediaQuery.of(context).size.width*0.02,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width*0.02,
                              ),
                              Row(
                                children: navBarItems,
                              )
                            ],
                          );
                          /*return Row(
                            children: navBarItems,
                          );*/
                        }
                      })
                    ],
                  ),
                ),

              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Color(0XffF5F5F5),
                  width: MediaQuery.of(context).size.width*0.4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.03,
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width*0.06,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0Xff2056a1),
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/APP - Pantalla Foto Perfil Referencial.png")
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: (){
                                //Navigator.push(context, PageTransition(child: LoginView(), type: PageTransitionType.rightToLeft));
                              },
                              child: Container(
                                child: Text("Cambiar foto",style: TextStyle(
                                  fontSize:MediaQuery.of(context).size.width*0.015,
                                ),),
                              ),
                            ),
                          ),

                          Icon(Icons.edit,size: MediaQuery.of(context).size.width*0.015,),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.02,
                      ),
                      Text("Nombre Apellido", style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: MediaQuery.of(context).size.width*0.014,
                      ),),
                      Text("correo@prueba.com",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.014,
                      ),),
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.02,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            //Navigator.push(context, PageTransition(child: LoginView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            child: Center(
                              child: Text("Cuenta Premium",
                                style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.014,),),
                            ),
                            /*margin: EdgeInsets.only(
                                        top: 30.0,
                                        left: 20.0,
                                        right: 20.0
                                    ),*/
                            height: MediaQuery.of(context).size.width*0.022,
                            width: MediaQuery.of(context).size.width*0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black,
                            ),),
                        ),
                      ),


                      SizedBox(
                        height:MediaQuery.of(context).size.width*0.04,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: ProfileView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.04,
                            width: MediaQuery.of(context).size.width*0.25,
                            color: Color(0XffE5E5E5),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.04,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Icon(Icons.assignment_ind_sharp, size:MediaQuery.of(context).size.width*0.02,  color: Color(0Xff2056a1)),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Text("Perfil", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:MediaQuery.of(context).size.width*0.02,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: MensajesView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.04,
                            width: MediaQuery.of(context).size.width*0.25,
                            color: Color(0XffE5E5E5),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.04,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Icon(Icons.mail_outline, size:MediaQuery.of(context).size.width*0.02,  color: Color(0Xff2056a1)),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Text("Mensajes", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02,
                                ),),
                              ],
                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height:MediaQuery.of(context).size.width*0.02,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: PublicacionesView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.04,
                            width: MediaQuery.of(context).size.width*0.25,
                            color: Color(0XffE5E5E5),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.04,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Icon(Icons.note_add_outlined, size:MediaQuery.of(context).size.width*0.02,  color: Color(0Xff2056a1)),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Text("Publicaciones", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02,
                                ),),
                              ],
                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height:MediaQuery.of(context).size.width*0.02,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: ContactosView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.04,
                            width: MediaQuery.of(context).size.width*0.25,
                            color: Color(0XffE5E5E5),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.04,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0Xff2056a1),
                                  ),
                                ),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Icon(Icons.person_add_alt, size:MediaQuery.of(context).size.width*0.02,  color: Color(0Xff2056a1)),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Text("Lista de contactos", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02,
                                ),),
                              ],
                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height:MediaQuery.of(context).size.width*0.02,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: CalendarView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.04,
                            width: MediaQuery.of(context).size.width*0.25,
                            color: Color(0XffE5E5E5),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.04,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Icon(Icons.calendar_today, size:MediaQuery.of(context).size.width*0.02,  color: Color(0Xff2056a1)),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.01,
                                ),
                                Text("Agenda", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02,
                                ),),
                              ],
                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height:MediaQuery.of(context).size.width*0.03,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.005,
                        ),
                        GestureDetector(
                          onTap: (){
                            //Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            child: Text(
                              "Contactos",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height*0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width*0.05,
                          ),
                          radius: MediaQuery.of(context).size.width*0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*0.03,
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text(
                                "Nombre Apellido", style:
                              TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.width*0.02
                              ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.006,
                            ),
                            Container(

                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.025,
                              child: Text("Empresa: xxxxxxxxxxxxxxx", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width*0.01
                              ),),
                            ),
                            Container(

                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.025,
                              child: Text("Cargo: xxxxxxxxxxxxxxxx", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width*0.01
                              ),),
                            ),
                            Container(

                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.025,
                              child: Text("Teléfono: xxxxxxxxxxxxxxxx", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width*0.01
                              ),),
                            ),
                            Container(

                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.025,
                              child: Text("Correo: xxxxxxxxxxx", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize:MediaQuery.of(context).size.width*0.01
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.06,
                    ),
                    Container(
                      color: Color(0XffC4C3C3),
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.001,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Resumen", style:
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height*0.02
                          ),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem trónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.", style:
                      TextStyle(
                          //fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width*0.012
                      ),textAlign: TextAlign.justify,),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    Container(
                      color: Color(0XffC4C3C3),
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.001,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          child: Text("Experciencia", style:
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height*0.02
                          ),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.", style:
                      TextStyle(
                        //fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width*0.012
                      ),textAlign: TextAlign.justify,),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),



                  ],
                ),
              ],
            ),
          ],),
      ),
    );
  }
}
class NavBarButton extends StatefulWidget {
  final Function onPressed;

  NavBarButton({
    this.onPressed,
  });

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0Xff2056a1),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            setState(() {
              widget.onPressed();
            });
          },
          child: Icon(
              Icons.menu,
              size: 30.0,
              color: Color(0Xff2056a1)
          ),
        ),
      ),
    );
  }
}
List<Widget> navBarItems = [
  NavBarItem(
    text: 'HOME',
  ),
  NavBarItem(
    text: 'MURAL',
  ),
  NavBarItem(
    text: 'TALLERES/EVENTOS',
  ),
  NavBarItem(
    text: 'CURSOS',
  ),
  NavBarItem(
    text: 'COMPRAS ONLINE',
  ),
  NavBarItem(
    text: 'CUPONERA',
  ),
  NavBarItem(
    text: 'BIBLIOTECA',
  ),
];

class NavBarItem extends StatefulWidget {
  final String text;
  final routing;

  NavBarItem({
    this.text,this.routing
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  Color color = notSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          color = selected;
        });
      },
      onExit: (value) {
        setState(() {
          color = notSelected;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            if( widget.text == 'HOME'){
              Navigator.push(context, PageTransition(child: FirstView(), type: PageTransitionType.bottomToTop));
            }
            if( widget.text == 'MURAL'){
              Navigator.push(context, PageTransition(child: MuralView(), type: PageTransitionType.bottomToTop));
            }
            if( widget.text == 'CURSOS'){
              Navigator.push(context, PageTransition(child: CursosView(), type: PageTransitionType.bottomToTop));
            }
            if( widget.text == 'COMPRAS ONLINE'){
              Navigator.push(context, PageTransition(child: ComprasOnlineView(), type: PageTransitionType.bottomToTop));
            }
            if( widget.text == 'TALLERES/EVENTOS'){
              Navigator.push(context, PageTransition(child: TalleresEventosView(), type: PageTransitionType.bottomToTop));
            }
            if( widget.text == 'CUPONERA'){
              Navigator.push(context, PageTransition(child: CuponeraView(), type: PageTransitionType.bottomToTop));
            }
          },
          child: Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}