import 'dart:html';

import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:provider/provider.dart';

import 'SearchDrawer.dart';



class AdministradorInformacionPage extends StatefulWidget {
  @override
  _AdministradorInformacionPage createState() => _AdministradorInformacionPage();
}

class _AdministradorInformacionPage extends State<AdministradorInformacionPage> {

  File PubIMG1,PubIMG2,PubIMG3;
  BlobImage PubPathIMG1,PubPathIMG2,PubPathIMG3;
  String Titabuscar="";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget card1(String img,String txt){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: (){
            _scaffoldKey.currentState.openEndDrawer();
            // _settingModalBottomSheet();
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) => SelectDialog(),
            // );
          },
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.30,
                height: MediaQuery.of(context).size.height*0.30,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(img)
                  ),
                ),
              ),
              Positioned(
                top:MediaQuery.of(context).size.width*0.15,
                left: MediaQuery.of(context).size.width*0.01,
                child: Container(
                  child: Text(txt, style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width*0.015,
                    fontWeight: FontWeight.w400,
                  ),),
                ),),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget Publicidad(double W, double H,int n){
    BlobImage img;
    switch (n) {
      case 1: img=PubPathIMG1;
        break;
      case 2: img =PubPathIMG2;
        break;
      case 3: img =PubPathIMG3;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: (){
            getImagegaleria(n);
          },
          child: Container(
            height:  H,
            width: W,
            color: Color(0Xff2056a1),
            child: img!=null
                ?Image.network(img.url):Center(
              child: Text("PUBLICIDAD",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),),
            ),
          )
      ),
    );
  }

  Widget Titulo(String tit, double W, double H){
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            child: Text(tit,style: TextStyle(
                fontSize: W*0.02,
                fontWeight: FontWeight.w600
            ),),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: W*0.85,
          height: H*0.004,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget Noticia(double ScreenWidth, double ScreenHeight){
    return Container(
        height: 260,
        width: ScreenHeight*0.62,
        decoration: BoxDecoration(
            border: Border.all(width: 0.5,color: Colors.black)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    child: Center(
                      child: Text("Texto referencial para colocar el título de una noticia",style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: ScreenWidth*0.011,
                          color: Colors.black
                      ),),
                    )
                ),
                SizedBox(
                  width: ScreenWidth*0.055,
                ),
                Container(
                  width: 55,
                  child: Text("Fecha: Hora:",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenWidth*0.01,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(height: ScreenHeight*0.03),
            Container(
              width: ScreenHeight*0.6,
              //margin: EdgeInsets.all(15),
              child: Center(
                child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",style:TextStyle(
                    fontSize: ScreenWidth*0.01,
                    //fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: Colors.black
                ),
                  textAlign: TextAlign.justify,),
              ),
            )
          ],
        )
    );
  }

  Widget NotaDestacada(double W, double H,String lugar){
    if(lugar=='der')
      return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          // Navigator.push(context, PageTransition(child: MuralViewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: W*0.38,
              height: 315,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/NOTA 1.png")
                ),
              ),
            ),
            Container(
              width: W*0.38,
              height: 315,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: W*0.2,
                        child: Text("Texto referencial para colocar el título de una noticia",style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: W*0.012,
                            color: Colors.black
                        ),),
                      ),
                      SizedBox(
                        width: W*0.03,
                      ),
                      Container(
                        width: W*0.03,
                        child: Text("Fecha: Hora:",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: W*0.008,
                            color: Colors.black
                        ),),
                      ),
                    ],
                  ),
                  Container(
                    width: 450,
                    margin: EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 15),
                    child: Center(
                      child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",style:TextStyle(
                          fontSize: W*0.009,
                          //fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.5
                      ),
                        textAlign: TextAlign.justify,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: W*0.027,
                          height: H*0.15,
                        ),
                        CircleAvatar(
                            radius: W*0.015,
                            backgroundColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/APP - Pantalla Foto Perfil Referencial.png")
                                ),
                              ),)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text("POR NOMBRE APELLIDO", style: TextStyle(
                            color: Colors.black,
                            fontSize: W*0.008,
                            fontWeight: FontWeight.w400,
                          ),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if(lugar=='izq')
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: (){
            // Navigator.push(context, PageTransition(child: MuralViewDetail(), type: PageTransitionType.rightToLeft));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: W*0.38,
                height: 315,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: W*0.2,
                          child: Text("Texto referencial para colocar el título de una noticia",style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: W*0.012,
                              color: Colors.black
                          ),),
                        ),
                        SizedBox(
                          width: W*0.03,
                        ),
                        Container(
                          width: W*0.03,
                          child: Text("Fecha: Hora:",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: W*0.008,
                              color: Colors.black
                          ),),
                        ),
                      ],
                    ),
                    Container(
                      width: 450,
                      margin: EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 15),
                      child: Center(
                        child: Text("Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",style:TextStyle(
                            fontSize: W*0.009,
                            //fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1.5
                        ),
                          textAlign: TextAlign.justify,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: W*0.027,
                            height: H*0.15,
                          ),
                          CircleAvatar(
                              radius: W*0.015,
                              backgroundColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/images/APP - Pantalla Foto Perfil Referencial.png")
                                  ),
                                ),)),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text("POR NOMBRE APELLIDO", style: TextStyle(
                              color: Colors.black,
                              fontSize: W*0.008,
                              fontWeight: FontWeight.w400,
                            ),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: W*0.38,
                height: 315,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/notas destacadas 2.png")
                  ),
                ),
              ),

            ],
          ),
        ),
      );
  }

  Widget Entrevista(){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          // Navigator.push(context, PageTransition(child: MuralViewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Container(
          width: 960,
          height: 700,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/ENTREVISTA I.png")
            ),
          ),
        ),
      ),
    );
  }

  Widget CardCurso(){
    double ScreenWidth=MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          // Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenWidth* 0.23,
              height: ScreenWidth*0.23,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/Curso II.png")
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text("Nombre del curso I", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: ScreenWidth*0.014),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text("Poniente: Nombre Apellido", style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenWidth*0.01,
                fontWeight: FontWeight.w400,
              ),),
            )
          ],
        ),
      ),
    );
  }

  Future getImagegaleria(int n) async {
    var tempImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() {
      if (n==1) {
        PubIMG1 = tempImage;
        PubPathIMG1 = new BlobImage(PubIMG1, name: PubIMG1.name);
      }
      if (n==2) {
        PubIMG2 = tempImage;
        PubPathIMG2 = new BlobImage(PubIMG2, name: PubIMG2.name);
      }
      if (n==3) {
        PubIMG3 = tempImage;
        PubPathIMG3 = new BlobImage(PubIMG3, name: PubIMG3.name);
      }
    });
  }

  void uploadPost() async {
    print('en upload');
    var timekey = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
        DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();

    // fb.StorageReference storageRef = fb.storage().ref("Cupon").child(timekey+imgPortada.name);
    // fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(imgPortada).future;
    //
    // Uri urlImgPortada = await uploadTaskSnapshot.ref.getDownloadURL();
    // cupon.portada=urlImgPortada.toString();
    //
    // FirestoreAPI().createCuponData(cupon);
  }



  Widget Taller(String img, String title, String subtitle){
    double ScreenWidth=MediaQuery.of(context).size.width;
    double ScreenHeight=MediaQuery.of(context).size.height;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          // Navigator.push(context, PageTransition(child: TalleresEventosVIewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height:ScreenHeight*0.33,
              width: ScreenWidth*0.35,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(img)
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: ScreenWidth*0.014),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(subtitle, style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenWidth*0.01,
                fontWeight: FontWeight.w400,
              ),),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth =MediaQuery.of(context).size.width;
    double ScreenHeight =MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: SearchDrawer(),
      endDrawerEnableOpenDragGesture: false,
      drawerEdgeDragWidth: ScreenWidth*0.5,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: ScreenWidth*0.001,
              height: ScreenHeight,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: ScreenWidth*0.77,
                height: ScreenHeight,
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          initialPage: 1,
                          autoPlay: true,
                        ),
                        items: [
                          Image(image: AssetImage("assets/images/Banner Principal - Home.png")),
                          Image(image: AssetImage("assets/images/Banner Principal - Home.png"),),
                          Image(image: AssetImage("assets/images/Banner Principal - Home.png"),),
                          Image(image: AssetImage("assets/images/Banner Principal - Home.png"),),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            width: ScreenWidth*0.6,
                            child: GridView.builder(
                              physics: new NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 225,
                              ),
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return card1( "assets/images/ricon del compliance 1.png","El rincón del compliance");
                              },
                            ),
                          ),
                          Publicidad(ScreenWidth*0.17,430,1),
                        ],
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Titulo("NOTICIAS",ScreenWidth,ScreenHeight),

                      SizedBox(
                        height: 40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Publicidad(ScreenWidth*0.35,260,2),
                          SizedBox(
                            width: ScreenWidth*0.02,
                          ),
                          Noticia(ScreenWidth,ScreenHeight),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Titulo("NOTAS DESTACADAS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      NotaDestacada(ScreenWidth, ScreenHeight,'der'),
                      SizedBox(
                        height: ScreenHeight*0.03,
                      ),
                      NotaDestacada(ScreenWidth, ScreenHeight,'izq'),
                      
                      SizedBox(
                        height: 40,
                      ),
                      Titulo("ENTREVISTAS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      Entrevista(),
                      SizedBox(
                        height: ScreenHeight*0.03,
                      ),
                      Publicidad(ScreenWidth, 397,3),
                      SizedBox(
                        height: 40,
                      ),
                      Titulo("CURSOS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: ScreenWidth,
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.73
                          ),
                          itemCount: 6,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return CardCurso();
                          },
                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Titulo("TALLERES/EVENTOS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Taller("assets/images/Talle I.png", "TALLER I", "Poniente: Nombre Apellido" ),
                          SizedBox(
                            width: ScreenWidth*0.05,
                          ),
                          Taller("assets/images/Taller II.png", "TALLER I", "Poniente: Nombre Apellido" ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );}
}