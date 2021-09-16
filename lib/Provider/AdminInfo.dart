import 'package:camp_web/model/Publicacion.dart';
import 'package:flutter/material.dart';

class AdmInfoProvider with ChangeNotifier {
  List<Publicacion> cards1=[];


  List<Publicacion> get Gcards1{ return cards1;}

  void addToCards(Publicacion pub) {
      cards1.add(pub);
      notifyListeners();
  }

}