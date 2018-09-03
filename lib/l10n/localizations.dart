import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/l10n/messages_all.dart';

class OutfitterLocalizationsDelegate
    extends LocalizationsDelegate<OutfitterLocalizations> {
  const OutfitterLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      application.supportedLanguages.contains(locale.languageCode);

  @override
  Future<OutfitterLocalizations> load(Locale locale) async {
    return OutfitterLocalizations.load(locale);
  }

  @override
  bool shouldReload(OutfitterLocalizationsDelegate old) => false;
}

class OutfitterLocalizations {
  static Future<OutfitterLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return OutfitterLocalizations();
    });
  }

  static OutfitterLocalizations of(BuildContext context) {
    return Localizations.of<OutfitterLocalizations>(
        context, OutfitterLocalizations);
  }

  String get labelAppName {
    return Intl.message('Outfitter', name: 'labelAppName');
  }
}
