import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/pages/discover/discover_page_legacy.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  BeveledRectangleProgressButtonState _googleSignInButtonState;

  @override
  void initState() {
    _googleSignInButtonState =
        BeveledRectangleProgressButtonState(onPressed: () {
      _signIn(context).then((FirebaseUser user) {
        //TODO
        _googleSignInButtonState.progress = false;
        _navigateToApp();
      }).catchError((e) => print(e));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.BACKGROUND,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BeveledRectangleProgressButton(
            _googleSignInButtonState,
            title: S.of(context).signInButtonTitle,
          )
        ],
      ),
    );
  }

  Future<FirebaseUser> _signIn(BuildContext context) async {
    _googleSignInButtonState.progress = true;
    GoogleSignInAccount googleUser = await application.googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    return await application.firebaseAuth.signInWithGoogle(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  }

  void _navigateToApp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscoverPageLegacy(),
      ),
    );
  }
}
