import 'package:camp_web/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as au;
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();
  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<au.User> streamFirebase = au.FirebaseAuth.instance.authStateChanges();
  Stream<au.User> get authStatus => streamFirebase;

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<au.User> signIn() {
    return _auth_repository.signFirebase();
  }

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
