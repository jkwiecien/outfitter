import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:outfitter/core/application.dart';

class Translations {
  Translations(this.locale);

  final Locale locale;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static String forKey(String key, BuildContext context) {
    Translations t = Translations.of(context);
//    print('Translations | $t');
    return t.text(key);
  }

  Map<String, String> _sentences;

  Future<bool> load() async {
//    print('Translations | Load file locale/${this.locale.languageCode}.json');
    String data =
        await rootBundle.loadString('locale/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);
//    print('Translations | $_result');

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String text(String key) {
    return this._sentences[key];
  }
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      application.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) async {
    Translations localizations = new Translations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
