import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/navigation/navigation_page.dart';
import 'package:outfitter/pages/auth/auth_page.dart';
import 'package:outfitter/utils/utils.dart';

void main() => runApp(new OutfitterApp());

class OutfitterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OutfitterAppState();
}

enum _AuthState { CHECKING, OK, ERROR }

class _OutfitterAppState extends State<OutfitterApp> {
  _AuthState _authState = _AuthState.CHECKING;

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
//      home: ItemWizardPage(ItemWizardPageState(Item.newInstance())),
//      home: DiscoverPage(),
      home: _initialPage(),
    );
  }

  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  void _checkAuth() {
    FirebaseAuth.instance.currentUser().then((firebaseUser) {
      setState(() {
        _authState = firebaseUser != null ? _AuthState.OK : _AuthState.ERROR;
      });
    });
  }

  Widget _initialPage() {
    switch (_authState) {
      case _AuthState.OK:
        return NavigationPage();
      case _AuthState.CHECKING:
        return Center(child: Text('LOADING'));
      default:
        return AuthPage();
    }
  }
}
