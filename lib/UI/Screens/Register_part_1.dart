
import 'package:camp_web/UI/Screens/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';






class Register_part1_view extends StatefulWidget{
  @override
  State createState() {
    return _Register_part1_view();
  }

}
class _Register_part1_view extends State<Register_part1_view>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
          child:Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.25,
                    color: Color(0Xff2056a1),
                  ),
                  Text("BIENVENIDA A CAMP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 30
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.of(context).pushNamed(ForgotPasswordRoute);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0Xff2056a1),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/APP - Pantalla Foto Perfil Referencial.png")
                      ),
                    ),
                  ),
                  radius: MediaQuery.of(context).size.height*0.13,
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  child: Text(
                    "Sube una foto",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  child: Text(
                    "Este es un texto referencial para colocar un mensaje de bienvenida a la plataforma",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.40,
                    color: Color(0Xff2056a1),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height*0.08,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        Navigator.push(context, PageTransition(child: FirstView(), type: PageTransitionType.rightToLeft));

                        /*if(_formKey.currentState.validate()){
                          await _auth.signInWithEmailAndPassword(_email, _password);
                        }*/
                      },
                      child: Text(
                        "COMENZAR",
                        style: TextStyle(color: Color(0Xff2056a1), fontSize: 20.0,
                            fontFamily: "BAHNSCHRIFT"),
                      ),
                    ),
                  ),

                ],
              ),
/*          CircleAvatar(
              radius: 25.0,
              backgroundImage:
              NetworkImage(user.photoURL)
          )*/
            ],
          ),
        )
    );
  }



}