//
// import 'package:camp/Usuarios/repository/firebase_auth_api.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_clean_calendar/clean_calendar_event.dart';
//
// class Calendario{
//
//   String titulo;
//   String id;
//   String fecha;
//   String Hora;
//   Calendario({this.titulo,this.fecha,this.id,this.Hora});
//
//   // Calendario.fromSnapshot(DocumentSnapshot snapshot){
//   //   titulo =snapshot['titulo'];
//   //   fecha=snapshot['fecha'];
//   // }
//
// }
// //
// // class CalendarioServices{
// //   String USERS = "usuarios";
// //   FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
// //
// //   Future<List<Calendario>> getAllProducts() async =>
// //       firebaseFiretore.collection(USERS).doc(uid).collection('calendario').get().then((result) {
// //         List<Calendario> Ceventos = [];
// //         for (DocumentSnapshot product in result.docs) {
// //           Ceventos.add(Calendario.fromSnapshot(product));
// //         }
// //         return Ceventos;
// //       });
// // }