import 'dart:html';

import 'package:camp_web/Provider/AdminInfo.dart';
import 'package:camp_web/model/Publicacion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:provider/provider.dart';

import 'SearchDrawer.dart';

class AdministradorInformacionPage extends StatefulWidget {
  @override
  _AdministradorInformacionPage createState() =>
      _AdministradorInformacionPage();
}

class _AdministradorInformacionPage
    extends State<AdministradorInformacionPage> {
  File PubIMG1, PubIMG2, PubIMG3;
  BlobImage PubPathIMG1, PubPathIMG2, PubPathIMG3;
  String Titabuscar = "";
  String ejtit = "Texto referencial para colocar el título de una noticia";
  String ejtext =
      "Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.";

  void _showSelectDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SearchDialog(i: index);
      },
    );
  }

  Widget card1(int index) {
    final _PubsProvider = Provider.of<AdmInfoProvider>(context, listen: true);

    Publicacion p = _PubsProvider.cards1[index];

    if (p == null)
      p = new Publicacion(
          titulo: "El rincón del compliance",
          portada:
              "https://firebasestorage.googleapis.com/v0/b/campproyect-69a08.appspot.com/o/Predeterminadas%2FLogo%20-%20Camp.png?alt=media&token=edf2846d-cd3e-4113-8d24-889ba3a4eaee");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return SearchDialog(i: index);
              },
            );
          },
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(p.portada)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.14,
                left: MediaQuery.of(context).size.width * 0.01,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    p.titulo,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.015,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Publicidad(double W, double H, int n) {
    BlobImage img;
    switch (n) {
      case 1:
        img = PubPathIMG1;
        break;
      case 2:
        img = PubPathIMG2;
        break;
      case 3:
        img = PubPathIMG3;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () {
            getImagegaleria(n);
          },
          child: Container(
            height: H,
            width: W,
            color: Color(0Xff2056a1),
            child: img != null
                ? Image.network(img.url)
                : Center(
                    child: Text(
                      "PUBLICIDAD",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
          )),
    );
  }

  Widget Titulo(String tit, double W, double H) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            child: Text(
              tit,
              style: TextStyle(fontSize: W * 0.02, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: W * 0.85,
          height: H * 0.004,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget Noticia(double ScreenWidth, double ScreenHeight) {
    return Container(
        height: 260,
        width: ScreenHeight * 0.62,
        decoration:
            BoxDecoration(border: Border.all(width: 0.5, color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    child: Center(
                      child: Text(
                        "Texto referencial para colocar el título de una noticia",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: ScreenWidth * 0.011,
                            color: Colors.black),
                      ),
                    )),
                SizedBox(
                  width: ScreenWidth * 0.055,
                ),
                Container(
                  width: 55,
                  child: Text(
                    "Fecha: Hora:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenWidth * 0.01,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenHeight * 0.03),
            Container(
              width: ScreenHeight * 0.6,
              //margin: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  "Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
                  style: TextStyle(
                      fontSize: ScreenWidth * 0.01,
                      //fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          ],
        ));
  }

  dynamic GETProviderData(int i) {
    final _PubsProvider = Provider.of<AdmInfoProvider>(context, listen: true);
    if (_PubsProvider.cards1[i] == null)
      return new Publicacion(
          titulo: "El rincón del compliance",
          portada:
              "https://firebasestorage.googleapis.com/v0/b/campproyect-69a08.appspot.com/o/Predeterminadas%2FLogo%20-%20Camp.png?alt=media&token=edf2846d-cd3e-4113-8d24-889ba3a4eaee",
          texto:
              "Es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.",
          Autorfoto:
              "https://firebasestorage.googleapis.com/v0/b/campproyect-69a08.appspot.com/o/Predeterminadas%2FIMG_Usuario_Predeterminado.png?alt=media&token=5aa86954-61cb-4b92-93a0-6de56f3389b5",
          Autorname: "Nombre completo de Autor");
    else
      return _PubsProvider.cards1[i];
  }

  Widget NotaDestacada(double W, double H, String lugar) {
    Publicacion p = GETProviderData(4);
    if (lugar == 'der')
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            _showSelectDialog(4);
          },
          child: Container(
            width: W * 0.8,
            height: 315,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: W * 0.37,
                  height: 315,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/NOTA 1.png")),
                  ),
                ),
                Container(
                  width: W * 0.37,
                  height: 315,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: W * 0.26,
                            height: H * 0.06,
                            child: Text(
                              p.titulo,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: W * 0.012,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            height: H * 0.06,
                            child: Column(
                              children: [
                                Container(
                                  width: W * 0.07,
                                  child: Text("Fecha: 15/10/2020",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: W * 0.008,
                                          color: Colors.black),
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  width: W * 0.07,
                                  child: Text("Hora: 13:30 P.M",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: W * 0.008,
                                          color: Colors.black),
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        width: 550,
                        height: 150,
                        child: Center(
                          child: Text(
                            p.texto,
                            style: TextStyle(
                              fontSize: W * 0.009,
                              color: Colors.black,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: W * 0.015,
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(p.Autorfoto)),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                p.Autorname,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: W * 0.008,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
        ),
      );
    if (lugar == 'izq')
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            _showSelectDialog(5);
          },
          child: Container(
            width: W * 0.8,
            height: 315,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: W * 0.37,
                  height: 315,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: W * 0.26,
                            height: H * 0.06,
                            child: Text(
                              p.titulo,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: W * 0.012,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            height: H * 0.06,
                            child: Column(
                              children: [
                                Container(
                                  width: W * 0.07,
                                  child: Text("Fecha: 15/10/2020",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: W * 0.008,
                                          color: Colors.black),
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  width: W * 0.07,
                                  child: Text("Hora: 13:30 P.M",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: W * 0.008,
                                          color: Colors.black),
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        width: 550,
                        height: 150,
                        child: Center(
                          child: Text(
                            p.texto,
                            style: TextStyle(
                              fontSize: W * 0.009,
                              color: Colors.black,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: W * 0.015,
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(p.Autorfoto)),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                p.Autorname,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: W * 0.008,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: W * 0.33,
                  height: 315,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/NOTA 1.png")),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget Entrevista() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, PageTransition(child: MuralViewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Container(
          width: 960,
          height: 700,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/ENTREVISTA I.png")),
          ),
        ),
      ),
    );
  }

  Widget CardCurso() {
    double ScreenWidth = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, PageTransition(child: CursosViewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenWidth * 0.23,
              height: ScreenWidth * 0.23,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/Curso II.png")),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Nombre del curso I",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenWidth * 0.014),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "Poniente: Nombre Apellido",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenWidth * 0.01,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getImagegaleria(int n) async {
    var tempImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() {
      if (n == 1) {
        PubIMG1 = tempImage;
        PubPathIMG1 = new BlobImage(PubIMG1, name: PubIMG1.name);
      }
      if (n == 2) {
        PubIMG2 = tempImage;
        PubPathIMG2 = new BlobImage(PubIMG2, name: PubIMG2.name);
      }
      if (n == 3) {
        PubIMG3 = tempImage;
        PubPathIMG3 = new BlobImage(PubIMG3, name: PubIMG3.name);
      }
    });
  }

  void uploadPost() async {
    print('en upload');
    var timekey = (DateTime.now().day +
            DateTime.now().month +
            DateTime.now().year +
            DateTime.now().hour +
            DateTime.now().minute +
            DateTime.now().second)
        .toString();

    // fb.StorageReference storageRef = fb.storage().ref("Cupon").child(timekey+imgPortada.name);
    // fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(imgPortada).future;
    //
    // Uri urlImgPortada = await uploadTaskSnapshot.ref.getDownloadURL();
    // cupon.portada=urlImgPortada.toString();
    //
    // FirestoreAPI().createCuponData(cupon);
  }

  Widget Taller(String img, String title, String subtitle) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, PageTransition(child: TalleresEventosVIewDetail(), type: PageTransitionType.rightToLeft));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenHeight * 0.33,
              width: ScreenWidth * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image:
                    DecorationImage(fit: BoxFit.fill, image: AssetImage(img)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenWidth * 0.014),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenWidth * 0.01,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: ScreenWidth * 0.001,
              height: ScreenHeight,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: ScreenWidth * 0.77,
                height: ScreenHeight,
                child: SingleChildScrollView(
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
                          Image(
                              image: AssetImage(
                                  "assets/images/Banner Principal - Home.png")),
                          Image(
                            image: AssetImage(
                                "assets/images/Banner Principal - Home.png"),
                          ),
                          Image(
                            image: AssetImage(
                                "assets/images/Banner Principal - Home.png"),
                          ),
                          Image(
                            image: AssetImage(
                                "assets/images/Banner Principal - Home.png"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: ScreenWidth * 0.6,
                            child: GridView.builder(
                              physics: new NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 225,
                              ),
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return card1(index);
                              },
                            ),
                          ),
                          Publicidad(ScreenWidth * 0.17, 430, 1),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Titulo("NOTICIAS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Publicidad(ScreenWidth * 0.35, 260, 2),
                          SizedBox(
                            width: ScreenWidth * 0.02,
                          ),
                          Noticia(ScreenWidth, ScreenHeight),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Titulo("NOTAS DESTACADAS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      NotaDestacada(ScreenWidth, ScreenHeight, 'der'),
                      SizedBox(
                        height: ScreenHeight * 0.03,
                      ),
                      NotaDestacada(ScreenWidth, ScreenHeight, 'izq'),
                      SizedBox(
                        height: 40,
                      ),
                      Titulo("ENTREVISTAS", ScreenWidth, ScreenHeight),
                      SizedBox(
                        height: 40,
                      ),
                      Entrevista(),
                      SizedBox(
                        height: ScreenHeight * 0.03,
                      ),
                      Publicidad(ScreenWidth, 397, 3),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.73),
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
                          Taller("assets/images/Talle I.png", "TALLER I",
                              "Poniente: Nombre Apellido"),
                          SizedBox(
                            width: ScreenWidth * 0.05,
                          ),
                          Taller("assets/images/Taller II.png", "TALLER I",
                              "Poniente: Nombre Apellido"),
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
    );
  }
}
