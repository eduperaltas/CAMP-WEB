import 'dart:html';
import 'package:camp_web/model/Cupon.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:camp_web/repository/firebase_auth_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_whisperer/image_whisperer.dart';
import 'package:intl/intl.dart';
import 'package:firebase/firebase.dart' as fb;


class AdministradorCrearCuponeraPage extends StatefulWidget {
  String mood;
  Cupon cupEdit;
  AdministradorCrearCuponeraPage({this.mood,this.cupEdit});
  @override
  _AdministradorCrearCuponeraPage createState() => _AdministradorCrearCuponeraPage();
}

class _AdministradorCrearCuponeraPage extends State<AdministradorCrearCuponeraPage> {
  String _pubTit,_pubText,_pubdir,_dateini,_datefin,namePDF,_categoria,_newCat,_urldir;
  File imgPortada,filePDF;
  Cupon cupon;
  BlobImage pathportada;

  var selectedCurrency;
  String sd="Selecciona";
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();


  Widget FormNewCat(String lbl,double sw,double sh){
    return Container(
      width: sw,
      height: sh,
      child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: lbl,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                )
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide()
            ),
          ),
          onChanged: (input) {
            setState(() => _newCat = input);
          }

      ),
    );
  }

  void _selectDate( bool ini) async {
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
        if(ini)
          _dateini =DateFormat('dd/MM/yyyy').format(newDate);
        else
          _datefin =DateFormat('dd/MM/yyyy').format(newDate);

      });
    }
     if(ini)
       _selectDate(!ini);
  }

  Future getImagegaleria(int n) async {
    print('en getimage');

    var tempImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() {
        imgPortada = tempImage;
        pathportada= new BlobImage(imgPortada, name: imgPortada.name);
      });
  }

  void uploadPost() async {
    print('en upload');
    var timekey = (DateTime.now().day+DateTime.now().month+DateTime.now().year+
        DateTime.now().hour+DateTime.now().minute+DateTime.now().second).toString();

    fb.StorageReference storageRef = fb.storage().ref("Cupon").child(timekey+imgPortada.name);
    fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(imgPortada).future;

    Uri urlImgPortada = await uploadTaskSnapshot.ref.getDownloadURL();
    cupon.portada=urlImgPortada.toString();

    fb.StorageReference storageRefPDF = fb.storage().ref("cuponesPDF").child(filePDF.name);
    fb.UploadTaskSnapshot uploadTaskSnapshotPDF = await storageRefPDF.put(filePDF).future;

    Uri urlImgPDF = await uploadTaskSnapshotPDF.ref.getDownloadURL();
    cupon.descarga=urlImgPDF.toString();

    FirestoreAPI().createCuponData(cupon);
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
            Text(carga,style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height*0.028
            ),),
            Container(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.height*0.13,
                child:  carga=='Cupón Creado'?
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

  Widget AddCatDialog(BuildContext context){
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width*0.15,
        height: MediaQuery.of(context).size.height*0.18,
        child: Column(
          children: [
            Text("Crear categoria",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height*0.028
            ),),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.01,
            ),
            FormNewCat('Nombre de categoria',MediaQuery.of(context).size.width*0.18,MediaQuery.of(context).size.height*0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.01,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CargaDialog('Creando Cupón',context),
                  );
                  FirestoreAPI().createCatCuponData(_newCat);
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                  },
                child: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                    fixedSize: Size(MediaQuery.of(context).size.width*0.05, MediaQuery.of(context).size.height*0.03),
                    primary: Color(0Xff2056a1)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BtnAgregaImg(int n,BlobImage pathimg){

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
                      child: Text(this.widget.mood=='edit'?"Editar portada":"Agregar portada",
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
        )
        :this.widget.mood=='edit'?Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width*0.4,
            height: MediaQuery.of(context).size.width*0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image:  NetworkImage(this.widget.cupEdit.portada)
              ),
            ),
          ),
        )
            :Container(),
      ],
    );
  }

  Widget BtnSelectFile(){
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
                  uploadFile();
                },
                child: Container(
                    alignment: Alignment.centerRight,
                    height: MediaQuery.of(context).size.height*0.04,
                    decoration: BoxDecoration(
                        color: Color(0Xff2056a1),
                        shape: BoxShape.rectangle
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(namePDF!=null?namePDF:"PDF del cupón",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width*0.01
                          ),),
                      ),
                    )
                ),
              ),
            ),
          ],)
      ],
    );
  }

  Widget BtnFecha(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width*0.15,
            height: MediaQuery.of(context).size.height*0.04,
            decoration: BoxDecoration(
                color: Color(0Xff2056a1),
                shape: BoxShape.rectangle
            ),
            child: Center(
              child: Text((_dateini!=null&&_datefin!=null)?'Del '+_dateini+' al '+_datefin
                  :this.widget.mood=='edit'?'Del '+this.widget.cupEdit.fechaini+' al '+this.widget.cupEdit.fechafin
                  :"Selecciona Fecha",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width*0.01
                ),),
            )
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.01,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (){  _selectDate(true);  },
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
      ],);
  }

  Widget Btnadd(){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          showDialog(
            context: context,
            builder: (context) => AddCatDialog(context),
          );
        },
        child: Container(
          decoration: new BoxDecoration(
            border: Border.all(
              color: Color(0Xff2056a1),
              width: MediaQuery.of(context).size.height*0.001,
            ),
            color: Color(0Xff2056a1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add,color:Colors.white,),
        ),),
    );
  }

  uploadFile() async {
    // HTML input element
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen(
          (changeEvent) {
        filePDF = uploadInput.files.first;
        final reader = FileReader();

        reader.readAsDataUrl(filePDF);

        reader.onLoadEnd.listen(
          // After file finiesh reading and loading, it will be uploaded to firebase storage
              (loadEndEvent) async {
                setState(() {
                  namePDF=filePDF.name;
                });
          },
        );
      },
    );
  }

  Widget categorias(){
    return Form(
      key: _formKeyValue,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("cupones")
              .doc('cats').collection('categorias').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(child: Text("Cargando..."));
            else {
              List<DropdownMenuItem> currencyItems = [];
              print('cats encontradas:${snapshot.data.docs.length}');
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot snap = snapshot.data.docs[i];
                currencyItems.add(
                  DropdownMenuItem(
                    child: Text(
                      snap.id,
                      style: TextStyle(color: Color(0Xff2056a1)),
                    ),
                    value: "${snap.id}",
                  ),
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: DropdownButton(
                      items: currencyItems,
                      onChanged: (currencyValue) {
                        setState(() {
                          selectedCurrency = currencyValue;
                          _categoria = currencyValue;
                        });
                      },
                      value: selectedCurrency,
                      isExpanded: false,
                      hint: new Text(
                        this.widget.mood=='edit'?this.widget.cupEdit.categoria:sd,
                        style: TextStyle(color: Color(0Xff2056a1)),
                      ),
                    ),
                  ),

                ],
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.widget.mood=='edit'?"Editar Cupón" : "Nuevo Cupón",
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
                  "Nombre del Cupón",
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
                initialValue:this.widget.mood=='edit'?this.widget.cupEdit.titulo:'',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0XFFf8f8ff),
                  hintText: "Nombre del Cupón",
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

          BtnFecha(),

          BtnAgregaImg(0, pathportada),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          Row(
            children: [

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Información del Cupón",
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
                maxLines: 12,
                initialValue:this.widget.mood=='edit'?this.widget.cupEdit.texto:'',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Información del Cupón",
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.015,
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
          BtnSelectFile(),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categoría del Cupón:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,0,0),
                child: categorias(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,0,0),
                child: Btnadd(),
              ),

            ],
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dirección",
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
                initialValue:this.widget.mood=='edit'?this.widget.cupEdit.direccion:'',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0XFFf8f8ff),
                  hintText: "Agregar la dirección del establecimiento",
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.015,
                  ),
                ),
                validator: (input)=> input.isEmpty ? 'Ingresa un título válido' : null,
                onChanged: (val){
                  setState(() => _pubdir = val);
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Link de Dirección",
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
                initialValue:this.widget.mood=='edit'?this.widget.cupEdit.urldirec:'',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0XFFf8f8ff),
                  hintText: "Agregar Link del establecimiento",
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.015,
                  ),
                ),
                onChanged: (val){
                  setState(() => _urldir = val);
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
                  onTap: (){
                    if(_pubText!=null && _pubTit!=null && _pubdir!=null&& _dateini!=null && _datefin!=null && pathportada!=null)
                    {
                      cupon= new Cupon(
                          id: _pubTit.substring(1,3)+uid.substring(1,3)+_dateini.substring(0,2)+_datefin.substring(0,2),
                          Autorid: uid,
                          titulo: _pubTit,
                          texto: _pubText,
                          fechafin: _datefin,
                          fechaini: _dateini,
                          direccion: _pubdir,
                          urldirec: _urldir,
                          categoria: _categoria,
                          estado: 'Activo');
                      uploadPost();
                      showDialog(
                        context: context,
                        builder: (context) => CargaDialog('Creando Cupón',context),
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        showDialog(
                          context: context,
                          builder: (context) => CargaDialog('Cupón Creado',context),
                        );
                      });
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context);
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