import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'Register_part_1.dart';
import 'login.dart';


class RegisterView extends StatefulWidget{
  @override
  State createState() {
    return _RegisterView();
  }
}
class _RegisterView extends State<RegisterView>{
  bool valuefirst = false;
  bool valuesecond = false;
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
                      image: AssetImage('assets/images/APP - Pantalla Crear Cuenta.png'),
                      fit : BoxFit.fitWidth,
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
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.03,
                            child: Text("Nombre", style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height*0.015,
                            ),),

                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0Xff2056a1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextFormField(
                                autocorrect: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10, top:MediaQuery.of(context).size.height*0.003),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0Xff2056a1),
                                    //fontFamily:
                                  ),
                                  hintText: 'Nombre',
                                ),

                                validator: (input)=> input.isEmpty ? 'Ingresa un nombre válido' : null,
                                onChanged: (val){
                                  //setState(() => _email = val);
                                },

                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.01,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.03,
                            child: Text("Apellido", style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height*0.015,
                            ),),

                          ),
                          Flexible(
                            child:Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0Xff2056a1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextFormField(
                                autocorrect: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10, top:MediaQuery.of(context).size.height*0.003),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: Color(0Xff2056a1),
                                      //fontFamily:
                                    ),
                                    hintText: 'Apellido'
                                ),
                                obscureText: true,
                                validator: (input)=> input.isEmpty ? 'Ingresa un apellido válido' : null,
                                onChanged: (val){
                                  //setState(() => _password = val);
                                },
                              ),
                            ),

                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.01,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.03,
                            child: Text("Correo Electrónico", style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height*0.015,
                            ),),

                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0Xff2056a1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextFormField(
                                autocorrect: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10, top:MediaQuery.of(context).size.height*0.003),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,

                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0Xff2056a1),
                                    //fontFamily:
                                  ),
                                  hintText: 'Correo electrónico',
                                ),

                                validator: (input)=> input.isEmpty ? 'Ingresa un Email válido' : null,
                                onChanged: (val){
                                  //setState(() => _email = val);
                                },

                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.01,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.03,
                            child: Text("Contraseña", style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height*0.015,
                            ),),

                          ),
                          Flexible(
                            child:Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              height: MediaQuery.of(context).size.height*0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0Xff2056a1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextFormField(
                                autocorrect: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10, top:MediaQuery.of(context).size.height*0.003),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: Color(0Xff2056a1),
                                      //fontFamily:
                                    ),
                                    hintText: 'Contraseña'
                                ),
                                obscureText: true,
                                validator: (input)=> input.length < 6 ? 'Ingresa una contraseña de más de seis carácteres' : null,
                                onChanged: (val){
                                  //setState(() => _password = val);
                                },
                              ),
                            ),

                          ),

                          Flexible(child: SizedBox(
                            height: 25.0,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Color(0Xff2056a1),
                                value: this.valuefirst,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.valuefirst = value;
                                  });
                                },
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.height*0.01,
                              ),
                              GestureDetector(
                                onTap: (){
                                  //Navigator.push(context, PageTransition(child: FirstView(), type: PageTransitionType.rightToLeft));
                                },
                                child: Container(
                                  child: Text(
                                    "Acepto los términos y condiciones",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context).size.height*0.02,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Flexible(child: SizedBox(
                            height: 25.0,
                          ),),
                          Flexible(child: GestureDetector(
                            onTap: (){

                              Navigator.push(context, PageTransition(child: Register_part1_view(), type: PageTransitionType.rightToLeft));


                              /*if(_formKey.currentState.validate()){
                          await _auth.signInWithEmailAndPassword(_email, _password);
                        }*/
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height*0.1,
                                  height: MediaQuery.of(context).size.height*0.1,
                                  decoration: BoxDecoration(
                                      color: Color(0Xff2056a1),
                                      shape: BoxShape.circle
                                  ),
                                  child: FittedBox(
                                    child: Icon(Icons.arrow_forward,
                                      size: MediaQuery.of(context).size.height*0.08,
                                      color: Colors.white,),
                                  ),
                                ),
                              ],
                            )
                          ),),
                          SizedBox(
                            height: 35,
                          ),
                          Flexible(child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, PageTransition(child: LoginView(), type: PageTransitionType.rightToLeft));
                            },
                            child: Container(
                              child: Text(
                                "Inicia Sesión",
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
                          ),
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