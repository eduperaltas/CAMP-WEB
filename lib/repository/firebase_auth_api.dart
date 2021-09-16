import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'dart:convert' as Json;
String uid = "gKzfmtPDAtO8YehAJmr7isU5BAJ3";
// String uid = FirebaseAuth.instance.currentUser.uid;
String name=FirebaseAuth.instance.currentUser.displayName;
String userEmail=FirebaseAuth.instance.currentUser.email;
String imageUrl=FirebaseAuth.instance.currentUser.photoURL;

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    UserCredential user = await _auth.signInWithCredential(GoogleAuthProvider.credential(idToken: gSA.idToken, accessToken: gSA.accessToken));
    uid= user.user.uid;
    name= user.user.displayName;
    userEmail= user.user.email;
    imageUrl= user.user.photoURL;
    return user.user;
  }

  Future<User> registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential user1 = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      uid= user1.user.uid;
      name= user1.user.displayName;
      userEmail= user1.user.email;
      imageUrl= user1.user.photoURL;
      return user1.user;

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{

    try{
      UserCredential user1 = await _auth.signInWithEmailAndPassword(email: email, password: password);
      uid= user1.user.uid;
      name= user1.user.displayName;
      userEmail= user1.user.email;
      imageUrl= user1.user.photoURL;
      return user1.user;

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  signOut() async {
    await _auth.signOut().then((onvalue) => print("Sesion cerrada"));
    googleSignIn.signOut();

    print(("sesiones cerradas"));
  }



}


