import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:outfitter/core/configuration.dart';

class Application {
  Future<FirebaseApp> firebaseApp() async {
    return await FirebaseApp.configure(
      name: Configuration.FIREBASE_APP_NAME,
      options: FirebaseOptions(
        googleAppID: Platform.isIOS
            ? Configuration.FIREBASE_IOS_APP_ID
            : Configuration.FIREBASE_ANDROID_APP_ID,
        gcmSenderID: Configuration.FIREBASE_SENDER_ID,
        apiKey: Configuration.FIREBASE_PROJECT_API_KEY,
        projectID: Configuration.FIREBASE_PROJECT_ID,
      ),
    );
  }

  Future<FirebaseStorage> firebaseStorage() async {
    return firebaseApp().then((firebaseApp) {
      return FirebaseStorage(
          app: firebaseApp,
          storageBucket: Configuration.FIREBASE_STORAGE_BUCKET);
    });
  }

  static final Application _application = new Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();
}

Application application = new Application();
