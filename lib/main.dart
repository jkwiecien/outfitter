import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/navigation/navigation_page.dart';
import 'package:outfitter/utils/utils.dart';

void main() => runApp(new OutfitterApp());

enum _InitState { PROGRESS, FINISHED, ERROR }

class OutfitterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OutfitterAppState();
}

class _OutfitterAppState extends State<OutfitterApp> {
//  _InitState _initState = _InitState.PROGRESS;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Outfitter',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: ColorConfig.THEME_PRIMARY),
        fontFamily: 'Rubik',
        brightness: Brightness.light,
        primaryColor: ColorConfig.THEME_PRIMARY,
        accentColor: ColorConfig.THEME_PRIMARY_DARK,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
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
      home: NavigationPage(),
    );
  }

  @override
  void initState() {
    application.isLoggedIn();
    super.initState();
  }

//  void _checkAuth() {
//    application.firebaseAuth.currentUser().then((user) {
//      application.user = user;
//    }).whenComplete(() {
//      setState(() {
//        _initState = _InitState.FINISHED;
//      });
//    }).catchError((error) {
//      setState(() {
//        _initState = _InitState.ERROR;
//      });
//    });
//  }

//  Widget get _initialPage {
//    switch (_initState) {
//      case _InitState.FINISHED:
//        return NavigationPage();
//      case _InitState.ERROR:
//        return Center(child: Text('Error'));
//      default:
//        return Center(child: Text('LOADING'));
//    }
//  }
}
