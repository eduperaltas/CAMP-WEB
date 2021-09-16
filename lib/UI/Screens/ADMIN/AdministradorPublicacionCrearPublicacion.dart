import 'dart:html';
import 'dart:js';

import 'package:camp_web/model/Publicacion.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:camp_web/repository/firebase_auth_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:firebase/firebase.dart' as fb;



class AdministradorCrearPublicacionesPage extends StatefulWidget {
  @override
  _AdministradorCrearPublicacionesPage createState() => _AdministradorCrearPublicacionesPage();
}

class _AdministradorCrearPublicacionesPage extends State<AdministradorCrearPublicacionesPage> {
  String _pubTit,_pubText;
  File imgPortada,img1,img2;
  Publicacion pub;
  BlobImage pathportada,pathimg1,pathimg2;

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
    });
  }

  void uploadPost() async {
    print('en upload');
    var timekey = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
        DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();

    fb.StorageReference storageRef = fb.storage().ref("Publicaciones").child('uid'+timekey+imgPortada.name);
    fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(imgPortada).future;

    Uri urlImgPortada = await uploadTaskSnapshot.ref.getDownloadURL();
    pub.portada=urlImgPortada.toString();

    if(img1!=null){
      var timekey1 = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
          DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();

      fb.StorageReference storageRef1 = fb.storage().ref("Publicaciones").child('uid'+timekey1+img1.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot1 = await storageRef1.put(img1).future;

      Uri urlImg1 = await uploadTaskSnapshot1.ref.getDownloadURL();
      pub.img1=urlImg1.toString();
    }

    if(img2!=null){
      var timekey2 = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
          DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();
      fb.StorageReference storageRef2 = fb.storage().ref("Publicaciones").child('uid'+timekey2+img2.name);
      fb.UploadTaskSnapshot uploadTaskSnapshot2 = await storageRef2.put(img2).future;

      Uri urlImg2 = await uploadTaskSnapshot2.ref.getDownloadURL();
      pub.img2=urlImg2.toString();
    }
    FirestoreAPI().createPublicacion(pub);
  }

  Widget CargaDialog(String carga, BuildContext context){
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width*0.7,
        height: MediaQuery.of(context).size.height*0.2,
        child: Column(
          children: [
            Text(carga=='listo'?"Publicacion Creada":"Creando Publicacion",style: TextStyle(
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
                    )):CircularProgressIndicator(color: Color(0Xff2056a1) ,strokeWidth: 8,)
            ),
          ],
        ),
      ),
    );
  }

  Widget BtnAgregaImg(int n,BlobImage pathimg, BuildContext context){
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  getImagegaleria(n);
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
                      child: Text(pathimg!=null?"Editar"+" imagen $n":"Agregar" +" imagen $n",
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
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                  "Mis publicaciones",
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
                  "Nueva Publicación",
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
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Título de Publicación",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02
                  ),
                ),
              )
            ],
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
                  hintText: "Título de la Publicación",
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.015,
                    //fontFamily:
                  ),
                ),

                validator: (input)=> input.isEmpty ? 'Ingresa un título válido' : null,
                onChanged: (val){
                  setState(() => _pubTit = val);
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
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){  getImagegaleria(0);  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width*0.15,
                      height: MediaQuery.of(context).size.height*0.04,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle
                      ),
                      child: Center(
                        child: Text("Imagen de portada",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width*0.01
                          ),),
                      )
                  ),
                ),
              ),
            ],),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: imgPortada!=null? NetworkImage(pathportada.url):AssetImage("assets/images/Logo - Camp.png")
                ),
              ),
            ),
          ),
          Row(
            children: [

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Texto de la Publicación",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02
                  ),
                ),
              )
            ],
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
                    //fontFamily:
                  ),
                ),

                validator: (input)=> input.isEmpty ? 'Ingresa un correo válido' : null,
                onChanged: (val){
                  setState(() => _pubText = val);
                },

              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          BtnAgregaImg(1,pathimg1,context),
          BtnAgregaImg(2,pathimg2,context),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    if(_pubTit!=null && _pubText!=null)
                    {
                      pub= new Publicacion(
                          uid: uid,
                          Autorname: 'name',
                          Autorfoto: 'imageUrl',
                          titulo: _pubTit,
                          texto: _pubText,
                          estado: 'Pendiente');
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
    );}
}