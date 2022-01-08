import 'package:flutter/material.dart';

class Anuncio {
  String id;
  String Autorid;
  String titulo;
  String texto;
  String portada;
  String estado;
  String fechaInicio;
  String fechaFin;

  //myFavoritePlaces
  //myPlaces
  Anuncio({
    Key Key,
    this.id,
    @required this.Autorid,
    @required this.titulo,
    @required this.texto,
    @required this.fechaInicio,
    @required this.fechaFin,
    @required this.estado,
    this.portada,
  });
}
