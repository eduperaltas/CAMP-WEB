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
    this.uid,
    this.Autorname,
    this.Autorfoto,
    this.titulo,
    this.texto,
    this.fecha,
    this.pubid,
    this.portada,
    this.img1,
    this.img2,
    this.estado,
  });
}
