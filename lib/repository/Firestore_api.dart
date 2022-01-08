import 'package:camp_web/model/Anuncio.dart';
import 'package:camp_web/model/Cupon.dart';
import 'package:camp_web/model/Curso.dart';
import 'package:camp_web/model/Evento.dart';
import 'package:camp_web/model/Publicacion.dart';
import 'package:camp_web/model/mensaje.dart';
import 'package:camp_web/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'firebase_auth_api.dart';

class FirestoreAPI {
  final String USERS = 'usuarios';
  final String MURAL = 'mural';
  final String EVENTOS = 'eventos';
  final String CURSOS = 'cursos';
  final String ANUNCIOS = 'anuncios';
  final String CUPONES = 'cupones';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String vid;
  String TipMensaje;
  String accion;
  String fecha;
  String filtro;
  int search;
  String Txtabuscar;

  FirestoreAPI(
      {this.vid,
      this.TipMensaje,
      this.accion,
      this.fecha,
      this.filtro,
      this.search,
      this.Txtabuscar});

  // FirestoreAPI({ this.uid});
  // PARAMETROS DE BUSQUEDA
  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  //****************************************************  USER  ****************************************************
  // Set USER
  void createUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    String search =
        user.lastname != null ? user.name + ' ' + user.lastname : user.name;
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'lastname': user.lastname,
      'email': user.email,
      'photoUrl': user.photoURL,
      'Creacion': DateTime.now(),
      'Estado': 'Activo',
      'Tipo de cuenta': 'Gratuita',
      "caseSearch": setSearchParam(search),
    });
  }

  // Get USER
  User userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: snapshot.data()['uid'],
      name: snapshot.data()['name'],
      lastname: snapshot.data()['lastname'] != null
          ? snapshot.data()['lastname']
          : "",
      email: snapshot.data()['email'],
      photoURL: snapshot.data()['photoUrl'],
      estado: snapshot.data()['Estado'],
      tipCuenta: snapshot.data()['Tipo de cuenta'],
    );
  }

  Stream<User> get userData {
    return _db
        .collection(USERS)
        .doc(vid != null ? vid : uid)
        .snapshots()
        .map(userDataFromSnapshot);
  }

  List<User> _usersDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return User(
        uid: doc['uid'],
        name: doc['name'],
        lastname: doc['lastname'] != null ? doc['lastname'] : "",
        email: doc['email'],
        photoURL: doc['photoUrl'],
        estado: doc['Estado'],
        tipCuenta: doc['Tipo de cuenta'],
      );
    }).toList();
  }

  Stream<List<User>> get usersData {
    return _db.collection(USERS).snapshots().map(_usersDataFromSnapshot);
  }

  void get_one_user() {
    _db.collection(USERS).doc(vid).get().then((doc) {
      // return User(
      //   uid: doc.data()['uid'],
      //   name: doc.data()['name'],
      //   lastname: doc.data()['lastname'] != null ? doc.data()['lastname'] : "",
      //   email: doc.data()['email'],
      //   photoURL: doc.data()['photoUrl'],
      //   estado: doc.data()['Estado'],
      //   tipCuenta: doc.data()['Tipo de cuenta'],
      // );
      print(doc.data()['name']);
    });
  }

  // Update USER
  void editProfilePhoto(String url) async {
    DocumentReference ref = _db.collection(USERS).doc(uid);
    return await ref.update({
      'photoUrl': url,
    });
  }

  void activar_cuenta(bool activo) {
    DocumentReference ref = _db.collection(USERS).doc(vid);
    ref.update({'Estado': activo ? 'Activo' : 'Desactivado'});
  }

//****************************************************  PUBLICACION  ****************************************************
// Set PUBLICACION

  void createPublicacion(Publicacion pub) async {
    String docnom = 'Pub' +
        uid +
        DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString();

    DocumentReference ref = _db.collection(MURAL).doc(docnom);

    String fecha = DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now());

    DocumentReference userRef =
        _db.collection(USERS).doc(uid).collection('publicaciones').doc(docnom);

    userRef.set({
      'Titulo': pub.titulo,
      'Estado': pub.estado,
      'Fecha': DateTime.now(),
    });
    return ref.set({
      'userid': pub.uid,
      'autor': pub.Autorname,
      'fotoAutor': pub.Autorfoto,
      'Titulo': pub.titulo,
      'Texto': pub.texto,
      'Portada': pub.portada,
      if (pub.img1 != null) 'Img1': pub.img1 else 'Img1': '',
      if (pub.img2 != null) 'Img2': pub.img2 else 'Img2': '',
      'Fecha': fecha,
      'Estado': pub.estado,
      "caseSearch": setSearchParam(pub.titulo),
    });
  }

  // Get PUBLICACION
  //en perfil
  List<Publicacion> _publicacionPerfinDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Publicacion(titulo: doc['Titulo'], estado: doc['Estado']);
    }).toList();
  }

  Stream<List<Publicacion>> get publicacionesPerfilData {
    return _db
        .collection(USERS)
        .doc(uid)
        .collection('publicaciones')
        .snapshots()
        .map(_publicacionPerfinDataFromSnapshot);
  }

  //en mural
  List<Publicacion> _publicacionesDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Publicacion(
        pubid: doc.id,
        titulo: doc['Titulo'],
        estado: doc['Estado'],
        Autorfoto: doc['fotoAutor'],
        Autorname: doc['autor'],
        texto: doc['Texto'],
        img1: doc['Img1'],
        img2: doc['Img2'],
        portada: doc['Portada'],
        fecha: doc['Fecha'].toString(),
      );
    }).toList();
  }

  Stream<List<Publicacion>> get publicacionesData {
    if (filtro != null) if (search == 1)
      return _db
          .collection(MURAL)
          .where('Estado', isEqualTo: filtro)
          .where("caseSearch", arrayContains: Txtabuscar)
          .snapshots()
          .map(_publicacionesDataFromSnapshot);
    else
      return _db
          .collection(MURAL)
          .where('Estado', isEqualTo: filtro)
          .snapshots()
          .map(_publicacionesDataFromSnapshot);
    else
      return _db
          .collection(MURAL)
          .snapshots()
          .map(_publicacionesDataFromSnapshot);
  }

  // //en Tabla
  // List<DataRow> _PubDataToROW(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc){
  //       return DataRow(cells: [
  //           DataCell(Container(
  //               width: 150,
  //               height: 60,
  //               child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: Text(
  //                     doc['Titulo'],maxLines: 2,overflow: TextOverflow.ellipsis,)))),
  //           DataCell(Row(
  //             children: [
  //               CircleAvatar(
  //                   radius: 15,
  //                   backgroundColor: Colors.white,
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       image: DecorationImage(
  //                           fit: BoxFit.cover,
  //                           image: NetworkImage(doc['fotoAutor'])
  //                       ),
  //                     ),)),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
  //                 child: Container(
  //                     width: 150,
  //                     height: 60,
  //                     child: Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: Text(
  //                           doc['autor'],maxLines: 2,overflow: TextOverflow.ellipsis),
  //                     )),
  //               ),
  //             ],
  //           )),
  //           DataCell(Text(doc['Fecha'].toString().substring(0,10))),
  //       ]);
  //   }).toList();
  // }

  // Stream<List<DataRow>> get publicacionesDataRow {
  //   if(search==1)
  //     return _db.collection(MURAL).where('Estado',isEqualTo: 'Aprobado').where("caseSearch", arrayContains: Txtabuscar).snapshots()
  //         .map(_PubDataToROW);
  //   else
  //     return _db.collection(MURAL).where('Estado',isEqualTo: 'Aprobado').snapshots()
  //         .map(_PubDataToROW);
  // }

  //CAMBIO DE ESTADO
  void Pubchangestate(bool aprobado, Publicacion p) {
    DocumentReference ref = _db.collection(MURAL).doc(p.pubid);
    DocumentReference userRef =
        _db.collection(USERS).doc(uid).collection('publicaciones').doc(p.pubid);

    ref.update({'Estado': aprobado ? 'Aprobado' : 'Rechazado'});
    userRef.update({'Estado': aprobado ? 'Aprobado' : 'Rechazado'});
  }

//****************************************************  CONTACTOS  ****************************************************
// Set CONTACT
  void createContactData(String name, String foto, String cid) async {
    DocumentReference ref =
        _db.collection(USERS).doc(uid).collection('contactos').doc(cid);
    return ref.set({
      'name': name,
      'photoUrl': foto,
      "caseSearch": setSearchParam(name),
    });
  }

//****************************************************  MENSAJES  ****************************************************
// Nuevo Mensaje
  void nuevoMensaje(Mensaje msj, bool borrador) async {
    DocumentReference refborrador = _db
        .collection(USERS)
        .doc(uid)
        .collection('mensajes')
        .doc('msj')
        .collection('borrador')
        .doc(msj.id);
    if (borrador) {
      refborrador.delete();
    }

    String dateTime = DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now());
    ;

    String nameMsj = 'F' +
        msj.idremitente.substring(1, 4) +
        DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString() +
        'T' +
        msj.iddestinatario.substring(1, 4);

    DocumentReference refemisor = _db
        .collection(USERS)
        .doc(msj.idremitente)
        .collection('mensajes')
        .doc('msj')
        .collection('enviados')
        .doc(nameMsj);
    refemisor.set({
      'idremitente': msj.idremitente,
      'iddestinatario': msj.iddestinatario,
      'Nremitente': msj.Nremitente,
      'Ndestinatario': msj.Ndestinatario,
      'fotoremit': msj.fotoremit,
      'fotodest': msj.fotodest,
      'mensaje': msj.mensaje,
      'fecha': dateTime,
      "caseSearch": setSearchParam(msj.Ndestinatario),
    });

    DocumentReference refdestino = _db
        .collection(USERS)
        .doc(msj.iddestinatario)
        .collection('mensajes')
        .doc('msj')
        .collection('entrada')
        .doc(nameMsj);
    return refdestino.set({
      'leido': false,
      'idremitente': msj.idremitente,
      'iddestinatario': msj.iddestinatario,
      'Nremitente': msj.Nremitente,
      'Ndestinatario': msj.Ndestinatario,
      'fotoremit': msj.fotoremit,
      'fotodest': msj.fotodest,
      'mensaje': msj.mensaje,
      'fecha': dateTime,
      "caseSearch": setSearchParam(msj.Nremitente),
    });
  }

// Visto
  void vistoMensaje(Mensaje msj) async {
    DocumentReference refvisto = _db
        .collection(USERS)
        .doc(uid)
        .collection('mensajes')
        .doc('msj')
        .collection(TipMensaje)
        .doc(msj.id);
    refvisto.update({'leido': true});
  }

// Eliminar Mensaje
  void eliminaMensaje(Mensaje msj, String seccion) async {
    DocumentReference refeliminados = _db
        .collection(USERS)
        .doc(uid)
        .collection('mensajes')
        .doc('msj')
        .collection('papelera')
        .doc(msj.id);

    if (seccion == 'papelera') {
      if (accion == 'recuperar') {
        DocumentReference refrecup = _db
            .collection(USERS)
            .doc(uid)
            .collection('mensajes')
            .doc('msj')
            .collection(msj.SecAnterior)
            .doc(msj.id);
        refrecup.set({
          'de': seccion,
          'idremitente': msj.idremitente,
          'iddestinatario': msj.iddestinatario,
          'Nremitente': msj.Nremitente,
          'Ndestinatario': msj.Ndestinatario,
          'fotoremit': msj.fotoremit,
          'fotodest': msj.fotodest,
          'mensaje': msj.mensaje,
          'fecha': msj.date,
          "caseSearch": setSearchParam(msj.Ndestinatario),
          'leido': true
        });
      }
      refeliminados.delete();
    } else {
      refeliminados.set({
        'de': seccion,
        'idremitente': msj.idremitente,
        'iddestinatario': msj.iddestinatario,
        'Nremitente': msj.Nremitente,
        'Ndestinatario': msj.Ndestinatario,
        'fotoremit': msj.fotoremit,
        'fotodest': msj.fotodest,
        'mensaje': msj.mensaje,
        'fecha': msj.date,
        "caseSearch": setSearchParam(msj.Ndestinatario),
      });

      DocumentReference refemisor = _db
          .collection(USERS)
          .doc(uid)
          .collection('mensajes')
          .doc('msj')
          .collection(TipMensaje)
          .doc(msj.id);
      return refemisor.delete();
    }
  }

// Mandar a borrador
  void MensajeBorrador(Mensaje msj) async {
    String dateTime = DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now());
    DocumentReference refemisor = _db
        .collection(USERS)
        .doc(uid)
        .collection('mensajes')
        .doc('msj')
        .collection('borrador')
        .doc(msj.id);
    refemisor.set({
      'idremitente': msj.idremitente,
      'iddestinatario': msj.iddestinatario,
      'Nremitente': msj.Nremitente,
      'Ndestinatario': msj.Ndestinatario,
      'fotoremit': msj.fotoremit,
      'fotodest': msj.fotodest,
      'mensaje': msj.mensaje,
      'fecha': dateTime,
      "caseSearch": setSearchParam(msj.Ndestinatario),
    });
  }

// GET Enviados
  //LEIDO HABRA PROBLEMA AL LEER SIN EL DATO LEIDO?
  List<Mensaje> _MensajeDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Mensaje(
          id: doc.id,
          fotodest: doc['fotodest'],
          fotoremit: doc['fotoremit'],
          iddestinatario: doc['iddestinatario'],
          idremitente: doc['idremitente'],
          mensaje: doc['mensaje'],
          Ndestinatario: doc['Ndestinatario'],
          Nremitente: doc['Nremitente'],
          date: doc['fecha'],
          leido: TipMensaje == 'entrada' ? doc['leido'] : null,
          SecAnterior: TipMensaje == 'papelera' ? doc['de'] : null);
    }).toList();
  }

  Stream<List<Mensaje>> get MensajesData {
    return _db
        .collection(USERS)
        .doc(uid)
        .collection('mensajes')
        .doc('msj')
        .collection(TipMensaje)
        .snapshots()
        .map(_MensajeDataFromSnapshot);
  }

//****************************************************  EVENTOS  ****************************************************
// Set EVENTO
  void createEventData(Evento e) async {
    DocumentReference ref = _db.collection(EVENTOS).doc(e.id);
    return ref.set({
      'autorID': e.Autorid,
      'estado': e.estado,
      'fecha': e.fecha,
      'titulo': e.titulo,
      'portada': e.portada,
      'texto': e.texto,
      'img1': e.img1,
      'img2': e.img2,
      'link': e.link,
      "caseSearch": setSearchParam(e.titulo),
    });
  }

  List<Evento> _eventossDataFromSnapshot(QuerySnapshot snapshot) {
//GET EVENTOS
    return snapshot.docs.map((doc) {
      return Evento(
        id: doc.id,
        Autorid: doc['autorID'],
        estado: doc['estado'],
        fecha: doc['fecha'],
        texto: doc['texto'],
        link: doc['link'],
        titulo: doc['titulo'],
        img1: doc['img1'],
        img2: doc['img2'],
        portada: doc['portada'],
      );
    }).toList();
  }

  Stream<List<Evento>> get eventossData {
    if (filtro != null) if (search == 1)
      return _db
          .collection(EVENTOS)
          .where('estado', isEqualTo: 'Activo')
          .where("caseSearch", arrayContains: Txtabuscar)
          .snapshots()
          .map(_eventossDataFromSnapshot);
    else
      return _db
          .collection(EVENTOS)
          .where('estado', isEqualTo: 'Activo')
          .snapshots()
          .map(_eventossDataFromSnapshot);
    else
      return _db.collection(EVENTOS).snapshots().map(_eventossDataFromSnapshot);
  }

//****************************************************  CURSOS  ****************************************************
// Set CURSO
  void createCursoData(Curso e) async {
    DocumentReference ref = _db.collection(CURSOS).doc(e.id);
    return ref.set({
      'autorID': e.Autorid,
      'estado': e.estado,
      'fecha': e.fecha,
      'titulo': e.titulo,
      'poniente': e.poniente,
      'imgponiente': e.imgponiente,
      'portada': e.portada,
      'link': e.link,
      'texto': e.texto,
      if (e.img1 != null) 'Img1': e.img1 else 'Img1': '',
      if (e.img2 != null) 'Img2': e.img2 else 'Img2': '',
      if (e.img3 != null) 'Img3': e.img3 else 'Img3': '',
      'link': e.link,
      "caseSearch": setSearchParam(e.titulo),
    });
  }

  List<Curso> _cursosDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Curso(
        id: doc.id,
        poniente: doc['poniente'],
        imgponiente: doc['imgponiente'],
        Autorid: doc['autorID'],
        estado: doc['estado'],
        link: doc['link'],
        fecha: doc['fecha'],
        texto: doc['texto'],
        titulo: doc['titulo'],
        img1: doc['Img1'],
        img2: doc['Img2'],
        img3: doc['Img3'],
        portada: doc['portada'],
      );
    }).toList();
  }

  Stream<List<Curso>> get cursossData {
    return _db
        .collection(CURSOS)
        .where('estado', isEqualTo: 'Activo')
        .snapshots()
        .map(_cursosDataFromSnapshot);
  }

  // ****************************************************  ANUNCIOS  ****************************************************
// Set ANUNCIO
  void createAnuncioData(Anuncio a) async {
    String docnom = 'Anu' +
        uid.substring(0, 3) +
        uid.substring(6, 9) +
        DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString().substring(2) +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString();

    DocumentReference ref = _db.collection(ANUNCIOS).doc(docnom);
    return ref.set({
      'autorID': a.Autorid,
      'estado': a.estado,
      'fechaI': a.fechaInicio,
      'fechaF': a.fechaFin,
      'titulo': a.titulo,
      'portada': a.portada,
      'texto': a.texto,
      "caseSearch": setSearchParam(a.titulo),
    });
  }

  //****************************************************  CUPON  ****************************************************
  // Set CAT
  void createCatCuponData(String cat) async {
    DocumentReference ref =
        _db.collection(CUPONES).doc('cats').collection('categorias').doc(cat);
    return ref.set({
      'fecha': DateFormat('dd/MM/yyyy kk:mm').format(DateTime.now()),
    });
  }

// Set CUPON
  void createCuponData(Cupon c) async {
    DocumentReference ref = _db.collection(CUPONES).doc(c.id);
    return ref.set({
      'autorID': c.Autorid,
      'estado': c.estado,
      'categoria': c.categoria,
      'fechaIni': c.fechaini,
      'fechaFin': c.fechafin,
      'titulo': c.titulo,
      'portada': c.portada,
      'descarga': c.descarga,
      'urldirec': c.urldirec,
      'texto': c.texto,
      'direccion': c.direccion,
      "caseSearch": setSearchParam(c.titulo),
    });
  }

  //GET CUPON
  List<Cupon> _cuponesDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cupon(
        id: doc.id,
        Autorid: doc['autorID'],
        estado: doc['estado'],
        fechaini: doc['fechaIni'],
        fechafin: doc['fechaFin'],
        texto: doc['texto'],
        titulo: doc['titulo'],
        portada: doc['portada'],
        direccion: doc['direccion'],
        urldirec: doc['urldirec'],
        categoria: doc['categoria'],
        descarga: doc['descarga'],
      );
    }).toList();
  }

  Stream<List<Cupon>> get cuponesData {
    return _db
        .collection(CUPONES)
        .where('estado', isNotEqualTo: 'cat')
        .snapshots()
        .map(_cuponesDataFromSnapshot);
  }

  // UPT ESTADO CUP
  void ChangeStateCupon(bool x, String id) async {
    DocumentReference ref = _db.collection(CUPONES).doc(id);
    return ref.update({
      'estado': x ? 'Activo' : 'Desactivo',
    });
  }

//****************************************************  CALENDARIO  ****************************************************
// Set CALENDARIO
//   void createCalendarioData(String tit,String date,String id) async{
//     DocumentReference ref= _db.collection(USERS).doc(uid).collection('calendario').doc(id);
//     return ref.set({
//       'titulo': tit,
//       'fecha': date.substring(0,10),
//       'hora': date.substring(12),
//     });
//   }
//
//   List<Calendario> _calendarioDataFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc){
//       return Calendario(
//         id: doc.id,
//         fecha: doc['fecha'],
//         Hora:  doc['hora'],
//         titulo: doc['titulo'],
//       );
//     }).toList();
//   }
//
//   Stream<List<Calendario>> get calendarioData {
//     return _db.collection(USERS).doc(uid).collection('calendario').where('fecha',isEqualTo: fecha).snapshots()
//         .map(_calendarioDataFromSnapshot);
//   }

}
