import 'package:flutter/material.dart';

class Publicacion {
  String uid;
  String Autorname;
  String Autorfoto;
  String titulo;
  String texto;
  String portada;
  String img1;
  String img2;
  String estado;
  String fecha;
  String pubid;

  //myFavoritePlaces
  //myPlaces
  Publicacion({
   Key Key,
   @required this.uid,
   @required this.Autorname,
   @required this.Autorfoto,
   @required this.titulo,
   @required this.texto,
   @required this.fecha,
   @required this.pubid,
   this.portada,
   this.img1,
   this.img2,
   @required this.estado,
   });
}
