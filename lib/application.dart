import 'package:flutter/material.dart';

class Application {
  final List<String> supportedLanguages = ['pl'];

  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  static final Application _application = new Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();
}

Application application = new Application();
