import 'package:flutter/material.dart';

class Cupon {
  String id;
  String Autorid;
  String titulo;
  String texto;
  String portada;
  String direccion;
  String estado;
  String descarga;
  String categoria;
  String fechaini;
  String fechafin;
  String urldirec;

  //myFavoritePlaces
  //myPlaces
  Cupon({
    Key Key,
    @required this.id,
    @required this.Autorid,
    @required this.titulo,
    @required this.texto,
    @required this.fechaini,
    @required this.fechafin,
    @required this.categoria,
    @required this.estado,
    @required this.descarga,
    this.direccion,
    this.urldirec,
    this.portada,
  });
}