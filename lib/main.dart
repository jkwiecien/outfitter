import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'application.dart';
import 'configuration.dart';
import 'pages/home.dart';
import 'translations.dart';

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
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConfig.THEME_PRIMARY_DARK,
              displayColor: ColorConfig.THEME_PRIMARY_DARK,
              decorationColor: ColorConfig.THEME_PRIMARY_DARK)),
      localizationsDelegates: [
        const TranslationsDelegate(),
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
      home: HomePage(),
    );
  }
}
