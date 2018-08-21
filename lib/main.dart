import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'application.dart';
import 'pages/home.dart';
import 'translations.dart';

void main() => runApp(new OutfitterApp(defaultLanguage: 'pl'));

class OutfitterApp extends StatefulWidget {
  OutfitterApp({
    this.defaultLanguage,
  });

  String defaultLanguage;

  @override
  _OutfitterAppState createState() => _OutfitterAppState();
}

class _OutfitterAppState extends State<OutfitterApp> {
  Locale defaultLocale;
  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();

    defaultLocale = Locale(widget.defaultLanguage);
    _localeOverrideDelegate = SpecificLocalizationDelegate(defaultLocale);

    ///
    /// Let's save a pointer to this method, should the user wants to change its language
    /// We would then call: applic.onLocaleChanged(new Locale('en',''));
    ///
    application.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Outfitter',
      theme: ThemeData(fontFamily: 'Poppins'),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
      home: HomePage(),
    );
  }
}
