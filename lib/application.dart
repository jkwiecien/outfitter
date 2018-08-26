import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Application {
  final List<String> supportedLanguages = ['pl'];

  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  Future<FirebaseApp> firebaseApp() async {
    return await FirebaseApp.configure(
      name: 'Outfitter',
      options: FirebaseOptions(
        googleAppID: Platform.isIOS
            ? 'FIXME 1:159623150305:ios:4a213ef3dbd8997b'
            : '1:867000703836:android:075f43e6d5d95982',
        gcmSenderID: '867000703836',
        apiKey: 'AIzaSyAz5UUHUQXmFcXENWb2L1SAJKte3uQd7kQ',
        projectID: 'pocket-outfitter',
      ),
    );
  }

  Future<FirebaseStorage> firebaseStorage() async {
    return firebaseApp().then((firebaseApp) {
      return FirebaseStorage(
          app: firebaseApp, storageBucket: 'gs://pocket-outfitter.appspot.com');
    });
  }

  static final Application _application = new Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();
}

Application application = new Application();
