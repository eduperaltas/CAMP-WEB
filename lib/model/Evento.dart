import 'package:flutter/material.dart';

class Evento {
  String id;
  String Autorid;
  String titulo;
  String texto;
  String portada;
  String link;
  String img1;
  String img2;
  String estado;
  String fecha;

  //myFavoritePlaces
  //myPlaces
  Evento({
   Key Key,
   @required this.id,
   @required this.Autorid,
   @required this.titulo,
   @required this.texto,
   @required this.link,
   @required this.fecha,
   this.portada,
   this.img1,
   this.img2,
   @required this.estado,
   });
}
