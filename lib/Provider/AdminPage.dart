import 'package:flutter/material.dart';

class AdmPageProvider with ChangeNotifier {
  String page='Informacion';
  String pubpage='Publicaciones de usuarios';
  String cuppage='Ver todos los cupones';
  String search='';


  String get Gpage{ return page;}
  String get Gpubpage{ return pubpage;}
  String get Gcuppage{ return cuppage;}
  String get Gsearch{ return search;}

  void changePage(String val){
    page=val;
    notifyListeners();
  }
  void changePubPage(String val){
    pubpage=val;
    notifyListeners();
  }
  void changeCupPage(String val){
    cuppage=val;
    notifyListeners();
  }

  void changeTxtSearch(String val){
    search=val;
    notifyListeners();
  }

}