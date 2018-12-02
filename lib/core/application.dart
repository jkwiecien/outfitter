import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Application {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final Application _application = new Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal() {
    firebaseAuth.currentUser().then((user) {
      application.user = user;
    });
  }

  FirebaseUser user;

  bool isLoggedIn() => user != null;
}

Application application = new Application();
