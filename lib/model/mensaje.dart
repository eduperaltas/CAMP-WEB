import 'package:flutter/material.dart';

class Mensaje {
  final String id;
  final String idremitente;
  final String iddestinatario;
  final String Nremitente;
  final String Ndestinatario;
  final String mensaje;
  final String fotoremit;
  final String fotodest;
  final String date;
  bool leido;
  String SecAnterior;

  //myFavoritePlaces
  //myPlaces
  Mensaje({
   Key Key,
   @required this.id,
   @required this.idremitente,
   @required this.iddestinatario,
   @required this.Nremitente,
   @required this.Ndestinatario,
   @required this.mensaje,
   @required this.fotoremit,
   @required this.fotodest,
    this.date,
    this.leido,
    this.SecAnterior,
   });
}
