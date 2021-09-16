import 'dart:html';
import 'package:camp_web/model/Evento.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:camp_web/repository/firebase_auth_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:intl/intl.dart';
import 'package:firebase/firebase.dart' as fb;


class AdministradorCrearTalleresPage extends StatefulWidget {
  @override
  _AdministradorCrearTalleresPage createState() => _AdministradorCrearTalleresPage();
}

class _AdministradorCrearTalleresPage extends State<AdministradorCrearTalleresPage> {
  String _titulo, _texto,_link;
  File imgPortada,img1,img2,img3;
  Evento event;
  String _date,_time;
  BlobImage pathportada,pathimg1,pathimg2,pathimg3;


  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      locale: Locale('es','PE'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 180)),
      helpText: 'Seleccione una fecha',
    );
    if (newDate != null) {
      setState(() {
        _date =DateFormat('dd/MM/yyyy').format(newDate);
      });
      _selectTime();
    }
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Seleccione una hora',
    );
    if (newTime != null) {
      setState(() {
        _time =  (newTime.hour<10?'0':'')+newTime.hour.toString()+':'+(newTime.minute<10?'0':'')+newTime.minute.toString()+' '+(newTime.hour<10?'A.M':'P.M');
      });
    }
  }

  Future getImagegaleria(int n) async {
    print('en getimage');
    var tempImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() {
      if(n==0) {
        imgPortada = tempImage;
        pathportada= new BlobImage(imgPortada, name: imgPortada.name);
      }
      if(n==1) {
        img1 = tempImage;
        pathimg1=new BlobImage(img1, name: img1.name);
      }
      if(n==2) {
        img2 = tempImage;
        pathimg2=new BlobImage(img2, name: img2.name);
      }
      if(n==3) {
        img3 = tempImage;
        pathimg3=new BlobImage(img3, name: img3.name);
      }
    });
  }

  void uploadPost() async {
    print('en upload');
    var timekey = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
        DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();

    fb.StorageReference storageRef = fb.storage().ref("Eventos").child(timekey+imgPortada.name);
    fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(imgPortada).future;

    Uri urlImgPortada = await uploadTaskSnapshot.ref.getDownloadURL();
    event.portada=urlImgPortada.toString();

    if(img1!=null){
      var timekey1 = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
          DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();

      fb.StorageReference storageRef1 = fb.storage().ref("Eventos").child(timekey1+img1.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot1 = await storageRef1.put(img1).future;

      Uri urlImg1 = await uploadTaskSnapshot1.ref.getDownloadURL();
      event.img1=urlImg1.toString();
    }

    if(img2!=null){
      var timekey2 = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
          DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();
      fb.StorageReference storageRef2 = fb.storage().ref("Eventos").child(timekey2+img2.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot2 = await storageRef2.put(img2).future;

      Uri urlImg2 = await uploadTaskSnapshot2.ref.getDownloadURL();
      event.img2=urlImg2.toString();
    }

    FirestoreAPI().createEventData(event);
  }

  Widget CargaDialog(String carga,BuildContext context){
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width*0.15,
        height: MediaQuery.of(context).size.height*0.2,
        child: Column(
          children: [
            Text(carga=='listo'?"Curso Creadao":"Creando Curso",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height*0.028
            ),),
            Container(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.height*0.13,
                child:  carga=='listo'?
                Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor:  Colors.green,
                      child: Icon(Icons.check,size: 70,color: Colors.white,),
                      radius: 70.0,
                    )):Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.height*0.5,
                    child: Center(child: CircularProgressIndicator(color: Color(0Xff2056a1) ,strokeWidth: 6,)))
            ),
          ],
        ),
      ),
    );
  }

  Widget BtnAgregaImg(int n,BlobImage pathimg,BuildContext context){
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  getImagegaleria(n);
                  // prueba();
                },
                child: Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width*0.15,
                    height: MediaQuery.of(context).size.height*0.04,
                    decoration: BoxDecoration(
                        color: Color(0Xff2056a1),
                        shape: BoxShape.rectangle
                    ),
                    child: Center(
                      child: Text(n==0?"Agregar portada":"Agregar imagen $n",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width*0.01
                        ),),
                    )
                ),
              ),
            ),
          ],),
        pathimg!=null?Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width*0.4,
            height: MediaQuery.of(context).size.width*0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image:  NetworkImage(pathimg.url)
              ),
            ),
          ),
        ):Container(),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.001,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        "Crear taller o Evento",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0Xff2056a1),
                            fontSize: MediaQuery.of(context).size.height*0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nuevo Evento",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height*0.02,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nombre del Evento",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02, top:MediaQuery.of(context).size.height*0.002 ),
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        fillColor: Color(0XFFf8f8ff),
                        hintText: "Nombre del Evento",
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.015,
                        ),
                      ),

                      validator: (input)=> input.isEmpty ? 'Ingresa un título válido' : null,
                      onChanged: (val){
                        setState(() => _titulo = val);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width*0.1,
                          height: MediaQuery.of(context).size.height*0.04,
                          decoration: BoxDecoration(
                              color: Color(0Xff2056a1),
                              shape: BoxShape.rectangle
                          ),
                          child: Center(
                            child: Text((_date!=null&&_time!=null)?_date+' '+_time:"Fecha",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width*0.01
                              ),),
                          )
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.01,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          _selectDate();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.022,
                          height: MediaQuery.of(context).size.width*0.022,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/agenda.png")
                            ),
                          ),
                        ),
                      ),
                    )
                  ],),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                BtnAgregaImg(0, pathportada, context),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Información del Evento",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02, top:MediaQuery.of(context).size.height*0.002 ),
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Texto de la Publicación",
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.015,
                        ),
                      ),

                      validator: (input)=> input.isEmpty ? 'Ingresa un correo válido' : null,
                      onChanged: (val){
                        setState(() => _texto = val);
                      },

                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Link del Evento",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02, /*top:MediaQuery.of(context).size.height*0.002*/ ),
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        fillColor: Color(0XFFf8f8ff),
                        hintText: "URL del Evento",
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.015,
                        ),
                      ),
                      validator: (input)=> input.isEmpty ? 'Ingresa un URL válido' : null,
                      onChanged: (val){
                        setState(() => _link = val);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                BtnAgregaImg(1,pathimg1,context),
                BtnAgregaImg(2,pathimg2,context),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          if(_titulo!=null && _texto!=null && _date!=null&& _time!=null && pathportada!=null)
                          {
                            event= new Evento(
                                id: _titulo.substring(1,3)+uid.substring(1,3)+_date.substring(0,2)+_time.substring(0,1),
                                Autorid: uid,
                                titulo: _titulo,
                                texto: _texto,
                                link: _link,
                                fecha: _date,
                                estado: 'Activo');
                            uploadPost();
                            showDialog(
                              context: context,
                              builder: (context) => CargaDialog('carga',context),
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              showDialog(
                                context: context,
                                builder: (context) => CargaDialog('listo',context),
                              );
                            });
                          }
                        },
                        child: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width*0.15,
                            height: MediaQuery.of(context).size.height*0.04,
                            decoration: BoxDecoration(
                                color: Color(0Xff2056a1),
                                shape: BoxShape.rectangle
                            ),
                            child: Center(
                              child: Text("Publicar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width*0.01
                                ),),
                            )
                        ),
                      ),
                    ),
                  ],),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),

              ],
            ),
          )
        ],
      ),
    );}
}