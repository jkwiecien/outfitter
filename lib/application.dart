import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class Application {
  // List of supported languages
  final List<String> supportedLanguages = ['en', 'pl'];

  // Returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  // Function to be invoked when changing the working language
  LocaleChangeCallback onLocaleChanged;

  ///
  /// Internals
  ///
  static final Application _application = new Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();
}

Application application = new Application();
