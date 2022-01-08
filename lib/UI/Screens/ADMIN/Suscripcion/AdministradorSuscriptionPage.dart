import 'dart:js';

import 'package:camp_web/model/user.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class AdministradorSuscripcionPage extends StatefulWidget {
  @override
  _AdministradorSuscripcionPage createState() => _AdministradorSuscripcionPage();
}

class _AdministradorSuscripcionPage extends State<AdministradorSuscripcionPage> {
  Widget Usuario(BuildContext context,User u){
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.25,
            child: Container(
              child: Text(u.name+' '+u.lastname, style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.width*0.015,
              ),),
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.23,
            child: Text(u.email,style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width*0.015,
            ),),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.16,
          child: Text('923827345',style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width*0.015,
          ),),
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
                          child: Text("Nombre",style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width*0.018,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.27,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Correo",style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width*0.018,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.16,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Center(
                          child: Text("Telefono",style: TextStyle(
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