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
import 'package:intl/intl.dart';
import 'SearchDrawer.dart';

class AdministradorInformacionPage extends StatefulWidget {
  @override
  _AdministradorInformacionPage createState() =>
      _AdministradorInformacionPage();
}

class _AdministradorInformacionPage
    extends State<AdministradorInformacionPage> {
  File pubIMG1, pubIMG2, pubIMG3;
  BlobImage pubPathIMG1, pubPathIMG2, pubPathIMG3;
  String titabuscar = "";
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
        Autorname: "Nombre completo de Autor",
        fecha: DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now()),
      );
    else
      return _PubsProvider.cards1[i];
  }

  Widget card1(int index) {
    final _PubsProvider = Provider.of<AdmInfoProvider>(context, listen: true);

    Publicacion p = GETProviderData(index);

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
        img = pubPathIMG1;
        break;
      case 2:
        img = pubPathIMG2;
        break;
      case 3:
        img = pubPathIMG3;
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
    Publicacion noticia = GETProviderData(4);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showSelectDialog(4);
        },
        child: Container(
            height: 260,
            width: ScreenWidth * 0.37,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 5, 5),
                      child: Container(
                          width: ScreenWidth * 0.23,
                          height: 43,
                          child: Text(
                            "${noticia.titulo}",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: ScreenWidth * 0.012,
                                color: Colors.black),
                          )),
                    ),
                    Column(
                      children: [
                        Container(
                          width: ScreenWidth * 0.1,
                          child: Text(
                              "Fecha: ${noticia.fecha.substring(0, 10)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenWidth * 0.008,
                                  color: Colors.black),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          width: ScreenWidth * 0.1,
                          child: Text("Hora: ${noticia.fecha.substring(11)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenWidth * 0.008,
                                  color: Colors.black),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: ScreenHeight * 0.03),
                Container(
                  width: ScreenWidth * 0.33,
                  height: 170,
                  //margin: EdgeInsets.all(15),
                  child: Text(
                    "${noticia.texto}",
                    style: TextStyle(
                        fontSize: ScreenWidth * 0.01,
                        //fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            )),
      ),
    );
  }

  String mesano(String fecha) {
    List<String> meses = [
      "ENE",
      "FEB",
      "MAR",
      "ABR",
      "MAY",
      "JUN",
      "JUL",
      "AGO",
      "SEP",
      "OCT",
      "NOV",
      "DIC"
    ];
    String mes = fecha.substring(3, 5);
    String ano = fecha.substring(6, 10);
    return meses[int.parse(mes) - 1] + "/" + ano;
  }

  Widget boxFecha(double W, double H, String fecha) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Container(
        width: W * 0.06,
        height: W * 0.06,
        color: Color(0Xff2056a1),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  fecha.substring(0, 2),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: W * 0.03,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  mesano(fecha),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: W * 0.01,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget NotaDestacada(double W, double H, String lugar) {
    List<Publicacion> nd = [GETProviderData(5), GETProviderData(6)];
    if (lugar == 'der')
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
                Stack(
                  children: [
                    Container(
                      width: W * 0.35,
                      height: 270,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(nd[0].portada)),
                      ),
                    ),
                    boxFecha(W, H, nd[0].fecha)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Container(
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
                                nd[0].titulo,
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
                                    child: Text(
                                        "Fecha: ${nd[0].fecha.substring(0, 10)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: W * 0.008,
                                            color: Colors.black),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    width: W * 0.07,
                                    child: Text(
                                        "Hora: ${nd[0].fecha.substring(11)}",
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
                              nd[0].texto,
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
                                          image: NetworkImage(nd[0].Autorfoto)),
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  nd[0].Autorname,
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
            _showSelectDialog(6);
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
                  height: 310,
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
                              nd[1].titulo,
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
                                  child: Text(
                                      "Fecha: ${nd[1].fecha.substring(0, 10)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: W * 0.008,
                                          color: Colors.black),
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  width: W * 0.07,
                                  child: Text(
                                      "Hora: ${nd[1].fecha.substring(11)}",
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
                            nd[1].texto,
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
                                        image: NetworkImage(nd[1].Autorfoto)),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                nd[1].Autorname,
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
                Stack(
                  children: [
                    Container(
                      width: W * 0.33,
                      height: 270,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(nd[1].portada)),
                      ),
                    ),
                    boxFecha(W, H, nd[0].fecha)
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget Entrevista() {
    Publicacion p = GETProviderData(7);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showSelectDialog(7);
        },
        child: Container(
          width: 960,
          height: 500,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(p.portada)),
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
        pubIMG1 = tempImage;
        pubPathIMG1 = new BlobImage(pubIMG1, name: pubIMG1.name);
      }
      if (n == 2) {
        pubIMG2 = tempImage;
        pubPathIMG2 = new BlobImage(pubIMG2, name: pubIMG2.name);
      }
      if (n == 3) {
        pubIMG3 = tempImage;
        pubPathIMG3 = new BlobImage(pubIMG3, name: pubIMG3.name);
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
          _showSelectDialog(8);
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

  Widget dgvCurso() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.73),
      itemCount: 6,
      itemBuilder: (BuildContext ctxt, int i) {
        return CardCurso();
      },
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
                      Container(width: ScreenWidth, child: dgvCurso()),
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
