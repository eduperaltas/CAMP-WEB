import 'package:flutter/material.dart';

class Curso {
  String id;
  String Autorid;
  String poniente;
  String titulo;
  String texto;
  String portada;
  String img1;
  String img2;
  String imgponiente;
  String img3;
  String estado;
  String fecha;
  String link;

  //myFavoritePlaces
  //myPlaces
  Curso({
   Key Key,
   @required this.id,
   @required this.Autorid,
   @required this.poniente,
   @required this.titulo,
   @required this.texto,
   @required this.fecha,
   this.portada,
   this.img1,
   this.imgponiente,
   this.img2,
   this.img3,
   this.link,
   @required this.estado,
   });
}
