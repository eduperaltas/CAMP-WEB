// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:camp_web/model/Curso.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:intl/intl.dart';
import 'package:firebase/firebase.dart' as fb;

class AdministradorCrearCursosPage extends StatefulWidget {
  @override
  _AdministradorCrearCursosPage createState() =>
      _AdministradorCrearCursosPage();
}

class _AdministradorCrearCursosPage
    extends State<AdministradorCrearCursosPage> {
  String _pubTit, _pubText, _date, _time, _poniente, _link;
  File imgPortada, img1, img2, img3, imgponiente;
  Curso curso;
  BlobImage pathportada, pathimg1, pathimg2, pathimg3, pathponiente;
  double ScreenW, ScreenH;

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      locale: Locale('es', 'PE'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 180)),
      helpText: 'Seleccione una fecha',
    );
    if (newDate != null) {
      setState(() {
        _date = DateFormat('dd/MM/yyyy').format(newDate);
      });
      _selectTime();
    }
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Seleccione una hora',
    );
    if (newTime != null) {
      setState(() {
        _time = (newTime.hour < 10 ? '0' : '') +
            newTime.hour.toString() +
            ':' +
            (newTime.minute < 10 ? '0' : '') +
            newTime.minute.toString() +
            ' ' +
            (newTime.hour < 10 ? 'A.M' : 'P.M');
      });
    }
  }

  Future getImagegaleria(int n) async {
    print('en getimage');

    var tempImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() {
      if (n == 0) {
        imgPortada = tempImage;
        pathportada = new BlobImage(imgPortada, name: imgPortada.name);
      }
      if (n == 1) {
        img1 = tempImage;
        pathimg1 = new BlobImage(img1, name: img1.name);
      }
      if (n == 2) {
        img2 = tempImage;
        pathimg2 = new BlobImage(img2, name: img2.name);
      }
      if (n == 3) {
        img3 = tempImage;
        pathimg3 = new BlobImage(img3, name: img3.name);
      }
      if (n == 4) {
        imgponiente = tempImage;
        pathponiente = new BlobImage(imgponiente, name: imgponiente.name);
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

    fb.StorageReference storageRef =
        fb.storage().ref("cursos").child(timekey + imgPortada.name);
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(imgPortada).future;

    Uri urlImgPortada = await uploadTaskSnapshot.ref.getDownloadURL();
    curso.portada = urlImgPortada.toString();

    if (img1 != null) {
      var timekey1 = (DateTime.now().day +
              DateTime.now().month +
              DateTime.now().year +
              DateTime.now().hour +
              DateTime.now().minute +
              DateTime.now().second)
          .toString();

      fb.StorageReference storageRef1 =
          fb.storage().ref("cursos").child(timekey1 + img1.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot1 =
          await storageRef1.put(img1).future;

      Uri urlImg1 = await uploadTaskSnapshot1.ref.getDownloadURL();
      curso.img1 = urlImg1.toString();
    }

    if (img2 != null) {
      var timekey2 = (DateTime.now().day +
              DateTime.now().month +
              DateTime.now().year +
              DateTime.now().hour +
              DateTime.now().minute +
              DateTime.now().second)
          .toString();
      fb.StorageReference storageRef2 =
          fb.storage().ref("cursos").child(timekey2 + img2.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot2 =
          await storageRef2.put(img2).future;

      Uri urlImg2 = await uploadTaskSnapshot2.ref.getDownloadURL();
      curso.img2 = urlImg2.toString();
    }
    if (img3 != null) {
      var timekey3 = (DateTime.now().day +
              DateTime.now().month +
              DateTime.now().year +
              DateTime.now().hour +
              DateTime.now().minute +
              DateTime.now().second)
          .toString();
      fb.StorageReference storageRef3 =
          fb.storage().ref("cursos").child(timekey3 + img3.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot3 =
          await storageRef3.put(img3).future;

      Uri urlImg3 = await uploadTaskSnapshot3.ref.getDownloadURL();
      curso.img3 = urlImg3.toString();
    }
    if (imgponiente != null) {
      var timekey4 = (DateTime.now().day +
              DateTime.now().month +
              DateTime.now().year +
              DateTime.now().hour +
              DateTime.now().minute +
              DateTime.now().second)
          .toString();
      fb.StorageReference storageRef4 =
          fb.storage().ref("cursos").child(timekey4 + imgponiente.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot4 =
          await storageRef4.put(imgponiente).future;

      Uri urlponiente = await uploadTaskSnapshot4.ref.getDownloadURL();
      curso.imgponiente = urlponiente.toString();
    }
    FirestoreAPI().createCursoData(curso);
  }

  Widget CargaDialog(String carga, BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Text(
              carga == 'listo' ? "Curso Creadao" : "Creando Curso",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.height * 0.028),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.13,
                child: carga == 'listo'
                    ? Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            size: 70,
                            color: Colors.white,
                          ),
                          radius: 70.0,
                        ))
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Color(0Xff2056a1),
                          strokeWidth: 6,
                        )))),
          ],
        ),
      ),
    );
  }

  Widget BtnAgregaImg(int n, BlobImage pathimg) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  getImagegaleria(n);
                  // prueba();
                },
                child: Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                        color: Color(0Xff2056a1), shape: BoxShape.rectangle),
                    child: Center(
                      child: Text(
                        "Agregar imagen $n",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.01),
                      ),
                    )),
              ),
            ),
          ],
        ),
        pathimg != null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain, image: NetworkImage(pathimg.url)),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget FormPoniente(String lbl, double sw, double sh) {
    return Container(
      width: sw,
      height: sh,
      child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: lbl,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          onChanged: (input) {
            setState(() => _poniente = input);
          }),
    );
  }

  Widget FormLink(String lbl, double sw, double sh) {
    return Container(
      width: sw,
      height: sh,
      child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: lbl,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          onChanged: (input) {
            setState(() => _link = input);
          }),
    );
  }

  Widget FormNomCurso(String lbl, double sw, double sh) {
    return Container(
      width: sw,
      height: sh,
      child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: lbl,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          onChanged: (input) {
            setState(() => _pubTit = input);
          }),
    );
  }

  Widget FormInfoCurso(String lbl, double sw, double sh) {
    return Container(
      width: sw,
      height: sh,
      child: TextFormField(
          cursorColor: Colors.black,
          maxLines: 20,
          decoration: InputDecoration(
            labelText: lbl,
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          onChanged: (input) {
            setState(() => _pubText = input);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenH = MediaQuery.of(context).size.height;
    ScreenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.001,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    child: Text(
                      "Crear Curso",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0Xff2056a1),
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nuevo Curso",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  FormNomCurso(
                      'Nombre del Curso', ScreenW * 0.2, ScreenH * 0.05),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imgponiente != null
                                          ? NetworkImage(pathponiente.url)
                                          : AssetImage(
                                              "assets/images/APP - Pantalla Foto Perfil Referencial.png")),
                                ),
                              )),
                          Positioned(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  getImagegaleria(4);
                                },
                                child: Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Color(0Xff2056a1),
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                    ),
                                    color: Color(0Xff2056a1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            left: MediaQuery.of(context).size.width * 0.045,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: FormPoniente(
                            'Poniente', ScreenW * 0.2, ScreenH * 0.05),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                              color: Color(0Xff2056a1),
                              shape: BoxShape.rectangle),
                          child: Center(
                            child: Text(
                              (_date != null && _time != null)
                                  ? 'Fecha: ' + _date + ' ' + _time
                                  : "Selecciona Fecha",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.01),
                            ),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _selectDate();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.022,
                            height: MediaQuery.of(context).size.width * 0.022,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/images/agenda.png")),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            getImagegaleria(0);
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: BoxDecoration(
                                  color: Color(0Xff2056a1),
                                  shape: BoxShape.rectangle),
                              child: Center(
                                child: Text(
                                  "Imagen de portada",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: imgPortada != null
                                ? NetworkImage(pathportada.url)
                                : AssetImage("assets/images/Logo - Camp.png")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FormInfoCurso(
                      "Información del Curso", ScreenW * 0.4, ScreenH * 0.4),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FormLink('Link', ScreenW * 0.4, 50),
                  ),
                  BtnAgregaImg(1, pathimg1),
                  BtnAgregaImg(2, pathimg2),
                  BtnAgregaImg(3, pathimg3),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_pubTit != null &&
                                _pubText != null &&
                                _date != null &&
                                _time != null &&
                                _link != null) {
                              curso = new Curso(
                                  id: _pubTit.substring(0, 3) +
                                      'admin124563258'.substring(5),
                                  Autorid: 'admin',
                                  titulo: _pubTit,
                                  poniente: _poniente,
                                  link: _link,
                                  texto: _pubText,
                                  fecha: _date + ' ' + _time,
                                  estado: 'Activo');
                              uploadPost();
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    CargaDialog('carga', context),
                              );
                              Future.delayed(Duration(seconds: 2), () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CargaDialog('listo', context),
                                );
                              });
                            }
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: BoxDecoration(
                                  color: Color(0Xff2056a1),
                                  shape: BoxShape.rectangle),
                              child: Center(
                                child: Text(
                                  "Publicar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
