import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/app_state.dart';
import 'package:outfitter/pages/discover/discover_page.dart';
import 'package:outfitter/redux/actions.dart';
import 'package:outfitter/redux/middleware.dart';
import 'package:outfitter/redux/reducers.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:redux/redux.dart';

void main() => runApp(new OutfitterApp());

class OutfitterApp extends StatelessWidget {
  final store = new Store<AppState>(appStateReducers,
      initialState: AppState.empty, middleware: [discoverListMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
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
          home: StoreBuilder<AppState>(
            onInit: (store) => store.dispatch(FetchDiscoverListAction()),
            builder: (context, store) => DiscoverPage(store),
          ),
        ));
  }
}
