import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';
import 'package:outfitter/widgets/widgets.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BeveledRectangleProgressButtonState _googleSignInButtonState;

  @override
  void initState() {
    _googleSignInButtonState =
        BeveledRectangleProgressButtonState(onPressed: () {
      _signIn(context).then((FirebaseUser user) {
        application.user = user;
        _googleSignInButtonState.progress = false;
        Navigator.pop(context, user);
      }).catchError((e) => print(e));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarFactory.flatAppBar(context,
          navigationIcon: Icons.close, title: S.of(context).authPageTitle),
      backgroundColor: ColorConfig.BACKGROUND,
      body: Padding(
        padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BeveledRectangleProgressButton(
              _googleSignInButtonState,
              title: S.of(context).googleSignInButtonTitle,
            )
          ],
        ),
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
}
