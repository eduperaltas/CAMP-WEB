import 'package:camp_web/model/user.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AdministradorHomePage extends StatefulWidget {
  @override
  _AdministradorHomePage createState() => _AdministradorHomePage();
}

class _AdministradorHomePage extends State<AdministradorHomePage> {

  Widget Usuario(BuildContext context,User u){
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.25,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  CircleAvatar(
                      radius: MediaQuery.of(context).size.width*0.02,
                      backgroundColor: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(u.photoURL)
                          ),
                        ),)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(u.name+' '+u.lastname, style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width*0.015,
                          fontWeight: FontWeight.w900,
                        ),),
                      ),
                      Container(
                        child: Text("ver perfil", style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width*0.01,
                          fontWeight: FontWeight.w400,
                        ),),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.015,
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.15,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.width*0.04,
                width: MediaQuery.of(context).size.width*0.2,
                child: Center(
                  child: Text(u.tipCuenta,style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width*0.015,
                  ),),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.16,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.width*0.04,
                width: MediaQuery.of(context).size.width*0.18,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(u.estado,style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width*0.01,
                    color: u.estado=='Activo'?Colors.green:Colors.red,
                  ),),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.17,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (){
                bool active=u.estado=='Activo'?false:true;
                FirestoreAPI(vid: u.uid).activar_cuenta(active);
                },
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width*0.04,
                    width: MediaQuery.of(context).size.width*0.15,
                    child: Center(
                      child: Text(u.estado=='Activo'?'Desactivar cuenta':'Activar cuenta',style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width*0.01,
                        color: u.estado=='Activo'?Colors.red:Colors.green,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget lista(){
    return StreamBuilder(
        stream: FirestoreAPI().usersData,
        builder: (context, snapshot) {
          List<User> lstusuarios=snapshot.data;
          if(!snapshot.hasData){
            return Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.7,
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Color(0Xff2056a1),)),
              ),
            );
          }
          if(lstusuarios.length>0){
            return Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.7,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lstusuarios.length,
                  itemBuilder: (context, i){
                    return Usuario(context,lstusuarios[i]);
                  }
              ),
            );
          }
          else
            return Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.7,
              child: Center(child: Text('No hay usuarios para mostrar.'),),);

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.001,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.79,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Usuarios",style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width*0.018,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.27,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Tipo de cuenta",style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width*0.018,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.16,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Estado",style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width*0.018,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.001,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  lista()
                ],
              ),
            ),
          ],
        ),
      ),
    );}
}