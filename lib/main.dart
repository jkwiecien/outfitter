import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/l10n/localizations.dart';
import 'package:outfitter/pages/discover/discover_page.dart';
import 'package:outfitter/pages/itemeditor/item_wizard.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils/utils.dart';

void main() => runApp(new OutfitterApp());

class OutfitterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Outfitter',
      theme: ThemeData(
        fontFamily: 'Rubik',
        brightness: Brightness.light,
        primaryColor: ColorConfig.THEME_PRIMARY,
        accentColor: ColorConfig.THEME_PRIMARY_DARK,
      ),
      localizationsDelegates: [
        const TranslationsDelegate(),
        const OutfitterLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
//      home: DiscoverPage(),
      home: DiscoverPage(),
    );
  }
}
