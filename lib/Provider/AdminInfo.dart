import 'package:camp_web/model/Publicacion.dart';
import 'package:flutter/material.dart';

class AdmInfoProvider with ChangeNotifier {


  List<dynamic> cards1=[null,null,null,null,null,null];


  List<dynamic> get Gcards1 { return cards1;}

  void addToCards(Publicacion pub) {
      cards1.add(pub);
      notifyListeners();
  }

  void updateCards(Publicacion pub, int index) {
    print('cambio en index: '+index.toString());
      cards1.removeAt(index);
      cards1.insert(index, pub);
      notifyListeners();
  }

}