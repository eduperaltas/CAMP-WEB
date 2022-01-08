
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'Register_part_1.dart';
import 'register.dart';


class LoginView extends StatefulWidget{
  @override
  State createState() {
    return _LoginView();
  }
}
class _LoginView extends State<LoginView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child:Stack(
                children: <Widget>
                [
                  Positioned.fill(  //
                    child: Image(
                      image: AssetImage('assets/images/APP - Pantalla Iniciar Sesion.png'),
                      fit : BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Form(
                      //key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/Logo - Camp.png")
                                ),
                              ),
                            ),
                            radius: MediaQuery.of(context).size.width*0.07,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.1,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0Xff2056a1),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextFormField(
                                autocorrect: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.mail,
                                    color: Color(0Xff2056a1),),
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0Xff2056a1),
                                    //fontFamily:
                                  ),
                                  labelText: '  Correo electrónico',
                                ),

                                validator: (input)=> input.isEmpty ? 'Ingresa un Email válido' : null,
                                onChanged: (val){
                                  //setState(() => _email = val);
                                },

                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.03,
                          ),
                          Flexible(
                            child:Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0Xff2056a1),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextFormField(
                                autocorrect: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock,
                                      color: Color(0Xff2056a1),),
                                    labelStyle: TextStyle(
                                      color: Color(0Xff2056a1),
                                      //fontFamily:
                                    ),
                                    labelText: '  Contraseña'
                                ),
                                obscureText: true,
                                validator: (input)=> input.length < 6 ? 'Ingresa una contraseña de más de seis carácteres' : null,
                                onChanged: (val){
                                  //setState(() => _password = val);
                                },
                              ),
                            ),

                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.03,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.06,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Colors.white,
                                onPressed: () async {
                                  Navigator.push(context, PageTransition(child: Register_part1_view(), type: PageTransitionType.rightToLeft));

                                  /*if(_formKey.currentState.validate()){
                          await _auth.signInWithEmailAndPassword(_email, _password);
                        }*/
                                },
                                child: Text(
                                  "INICIA SESIÓN",
                                  style: TextStyle(color: Color(0Xff2056a1), fontSize: 20.0,
                                      fontFamily: "BAHNSCHRIFT"),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),

                          Flexible(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Flexible(child: GestureDetector(
                                onTap: (){
                                  //Navigator.of(context).pushNamed(ForgotPasswordRoute);
                                },
                                child: Image(
                                    height: 35,
                                    image: AssetImage('assets/images/facebook.png',)
                                ),
                              ),),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(child: GestureDetector(
                                onTap: (){
                                  //Navigator.of(context).pushNamed(ForgotPasswordRoute);
                                },
                                child: Image(
                                    height: 35,
                                    image: AssetImage('assets/images/google-plus.png',)
                                ),
                              ),),

                            ],
                          ),),
                          SizedBox(
                            height: 45,
                          ),
                          Flexible(child: GestureDetector(
                            onTap: (){
                              //Navigator.of(context).pushNamed(ForgotPasswordRoute);
                            },
                            child: Container(
                              child: Text(
                                "Regístrate",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),),
                          SizedBox(
                            height: 25,
                          ),
                          Flexible(child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.rightToLeft));
                            },
                            child: Container(
                              child: Text(
                                "Olvidaste tu contraseña?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(child: GestureDetector(
                                onTap: (){
                                  //Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.rightToLeft));
                                },
                                child: Container(
                                  child: Text(
                                    "Preguntas Frecuentes",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),),
                              Flexible(child: GestureDetector(
                                onTap: (){
                                  //Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.rightToLeft));
                                },
                                child: Container(
                                  child: Text(
                                    "Términos y Condiciones",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),),
                            ],
                          )

                        ],
                      ),

                    ),
                  )

                ]
            )
        )
    );
  }


}