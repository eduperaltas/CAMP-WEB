import 'package:camp_web/UI/Screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';
import 'ADMIN/AdministradorHomePage.dart';
import 'Calendar.dart';
import 'ComprasOnline.dart';
import 'CuponeraView.dart';
import 'CursosViewDetail.dart';
import 'HomeView.dart';
import 'Mensajes_Buzon.dart';
import 'MisionVision.dart';
import 'MuralView.dart';
import 'PolíticasDePrivacidad.dart';
import 'PreguntasFrecuentes.dart';
import 'Prensa.dart';
import 'QuienesSomos.dart';
import 'Register_part_1.dart';
import 'SociasCamp.dart';
import 'Soporte.dart';
import 'TalleresEventos.dart';
import 'TerminosYCondiciones.dart';
import 'login.dart';

class CursosView extends StatefulWidget{
  @override
  State createState() {
    return _CursosView();
  }
}
class _CursosView extends State<CursosView>{
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
            Container(
              child: Text("Cursos", style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*0.02,
                  fontWeight: FontWeight.w900
              ),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width*0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos i.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso I", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
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
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos ii.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso II", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
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
                        Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/imagen - cursos iii.png")
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text("Nombre del curso III", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text("Poniente: Nombre Apellido", style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width*0.01,
                              fontWeight: FontWeight.w400,
                            ),),
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos i.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso I", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
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
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos ii.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso II", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
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
                        Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/imagen - cursos iii.png")
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text("Nombre del curso III", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text("Poniente: Nombre Apellido", style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width*0.01,
                              fontWeight: FontWeight.w400,
                            ),),
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos i.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso I", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
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
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos ii.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso II", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
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
                      Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/imagen - cursos iii.png")
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text("Nombre del curso III", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text("Poniente: Nombre Apellido", style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width*0.01,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width*0.03,
            ),
            Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Container(
                  color: Color(0xcfffffff),
                  //height: MediaQuery.of(context).size.width*0.18,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LayoutBuilder(builder: (context, constraints) {
                        if (width < 800.0) {
                          return Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              height: MediaQuery.of(context).size.height*0.4,
                              color: Color(0Xff2056a1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    child: Text("SOBRE NOSOTROS",style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width*0.03
                                    ),
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.6,
                                    height: MediaQuery.of(context).size.height*0.07,
                                    child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor ", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context).size.width*0.02,
                                        height: 1.5

                                    ),
                                      textAlign: TextAlign.justify,),
                                  ),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      height: MediaQuery.of(context).size.height*0.03,
                                      child: Center(
                                        child: Text("Quienes Somos",style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context).size.width*0.03,
                                            height: 1.5
                                        ),),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: MediaQuery.of(context).size.height*0.03,
                                        child: Center(
                                          child: Text("Misión y Visión",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.03,
                                              height: 1.5
                                          ),),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: MediaQuery.of(context).size.height*0.03,
                                        child: Center(
                                          child: Text("Socias CAMP",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.03,
                                              height: 1.5
                                          ),),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: MediaQuery.of(context).size.height*0.03,
                                        child: Center(
                                          child: Text("Prensa",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.03,
                                              height: 1.5
                                          ),),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      height: MediaQuery.of(context).size.height*0.03,
                                      child: Center(
                                        child: Text("Preguntas Frecuentes",style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context).size.width*0.03,
                                            height: 1.5
                                        ),),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: MediaQuery.of(context).size.height*0.03,
                                        child: Center(
                                          child: Text("Políticas de Privacidad",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.03,
                                              height: 1.5
                                          ),),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: MediaQuery.of(context).size.height*0.03,
                                        child: Center(
                                          child: Text("Términos y Condiciones",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.03,
                                              height: 1.5
                                          ),),
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: MediaQuery.of(context).size.height*0.03,
                                        child: Center(
                                          child: Text("Soporte",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.03,
                                              height: 1.5
                                          ),),
                                        )
                                    ),
                                  ),

                                ],
                              )
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.96,
                                height: MediaQuery.of(context).size.height*0.3,
                                color:  Color(0Xff2056a1),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.2,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          child: Text("SOBRE NOSOTROS",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: MediaQuery.of(context).size.width*0.015
                                          ),),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.25,
                                          height: MediaQuery.of(context).size.height*0.1,
                                          child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor ", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*0.01,
                                              height: 1.5

                                          ),
                                            textAlign: TextAlign.justify,),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MouseRegion(
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: QuienesSomosView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              height: MediaQuery.of(context).size.height*0.03,
                                              child: Center(
                                                child: Text("Quiénes Somos",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).size.width*0.01,
                                                    height: 1.5
                                                ),),
                                              ),
                                            ),
                                          ),
                                          cursor: SystemMouseCursors.click,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: MisionVisionView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              height: MediaQuery.of(context).size.height*0.03,
                                              child: Center(
                                                child: Text("Misión y Visión",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).size.width*0.01,
                                                    height: 1.5
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        MouseRegion(
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: SociasCampView(), type: PageTransitionType.rightToLeft));

                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              height: MediaQuery.of(context).size.height*0.03,
                                              child: Center(
                                                child: Text("Socias CAMP",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).size.width*0.01,
                                                    height: 1.5
                                                ),),
                                              ),
                                            ),
                                          ),
                                          cursor: SystemMouseCursors.click,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: PrensaView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              height: MediaQuery.of(context).size.height*0.03,
                                              child: Center(
                                                child: Text("Prensa",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).size.width*0.01,
                                                    height: 1.5
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: PreguntasFrecuentesView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              height: MediaQuery.of(context).size.height*0.03,
                                              child: Center(
                                                child: Text("Preguntas Frecuentes",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).size.width*0.01,
                                                    height: 1.5
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child:  GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: PoliticasDePrivacidadView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context).size.width*0.2,
                                                height: MediaQuery.of(context).size.height*0.03,
                                                child: Center(
                                                  child: Text("Políticas de Privacidad",style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width*0.01,
                                                      height: 1.5
                                                  ),),
                                                )
                                            ),
                                          ),
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: TerminosYCondicionesView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context).size.width*0.2,
                                                height: MediaQuery.of(context).size.height*0.03,
                                                child: Center(
                                                  child: Text("Términos y Condiciones",style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width*0.01,
                                                      height: 1.5
                                                  ),),
                                                )
                                            ),
                                          ),
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child:GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(child: SoporteView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context).size.width*0.2,
                                                height: MediaQuery.of(context).size.height*0.03,
                                                child: Center(
                                                  child: Text("Soporte",style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width*0.01,
                                                      height: 1.5
                                                  ),),
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.96,
                                height: MediaQuery.of(context).size.height*0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    MouseRegion(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.rightToLeft));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.2,
                                          height: MediaQuery.of(context).size.height*0.03,
                                          child: Container(
                                            child: Center(
                                              child: Text("SUSCRÍBETE", style:TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width*0.015,
                                                  color: Colors.black
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ),
                                      cursor: SystemMouseCursors.click,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.25,
                                          height: MediaQuery.of(context).size.width*0.04,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
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
                                              hintText: "Correo Electrónico",
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
                                        MouseRegion(
                                          child: GestureDetector(
                                            onTap: (){
                                              //Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.rightToLeft));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:Color(0Xff2056a1),
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              width: MediaQuery.of(context).size.width*0.09,
                                              height: MediaQuery.of(context).size.width*0.04,
                                              child: FlatButton(
                                                shape: new RoundedRectangleBorder(
                                                ),
                                                color:Color(0Xff2056a1),
                                                onPressed: () async {
                                                  Navigator.push(context, PageTransition(child: Register_part1_view(), type: PageTransitionType.rightToLeft));
                                                },
                                                child: Text(
                                                  "Enviar",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).size.width*0.01,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          cursor: SystemMouseCursors.click,
                                        ),

                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.03,
                                      height: MediaQuery.of(context).size.width*0.03,
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
                                  ],
                                ),
                              ),

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
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, PageTransition(child: AdministradorHomePage(), type: PageTransitionType.rightToLeft));
              },
              child: Container(
                child: Text("Admin"),
              )
              ,
            ),
          ],
        ),
      )
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