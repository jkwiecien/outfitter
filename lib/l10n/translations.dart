import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/l10n/messages_all.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      application.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) async {
    return Translations.load(locale);
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class Translations {
  static Future<Translations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return Translations();
    });
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String get appNameLabel {
    return Intl.message('Outfitter', name: 'appNameLabel');
  }

  String get createItemPageTitle {
    return Intl.message('Tworzenie', name: 'createItemPageTitle');
  }

  String get editItemPageTitle {
    return Intl.message('Edycja', name: 'editItemPageTitle');
  }

  String get categoryPickerPageTitle {
    return Intl.message('Wybierz kategorię', name: 'categoryPickerPageTitle');
  }

  String get categoryButtonTitle {
    return Intl.message('Kategoria', name: 'categoryButtonTitle');
  }

  String get categoryLabel {
    return Intl.message('Kategoria', name: 'categoryLabel');
  }

  String get descriptionInputHint {
    return Intl.message('Opis', name: 'descriptionInputHint');
  }

  String get brandInputHint {
    return Intl.message('Producent', name: 'brandInputHint');
  }

  String get generalErrorMessage {
    return Intl.message('Coś poszło nie tak', name: 'generalErrorMessage');
  }

  String get fieldRequiredErrorMessage {
    return Intl.message('Pole wymagane', name: 'fieldRequiredErrorMessage');
  }

  String get categoryRequiredErrorMessage {
    return Intl.message('Wybierz kategorię',
        name: 'categoryRequiredErrorMessage');
  }

  String get loadingLabel {
    return Intl.message('Trwa ładowanie danych', name: 'loadingLabel');
  }

  String get saveAction {
    return Intl.message('Zapisz', name: 'saveAction');
  }

  String get notSelectedLabel {
    return Intl.message('Nie wybrano', name: 'notSelectedLabel');
  }

  String get informationLabel {
    return Intl.message('Informacje', name: 'informationLabel');
  }

  String get mainColorLabel {
    return Intl.message('Kolor główny', name: 'mainColorLabel');
  }

  String get photosLabel {
    return Intl.message('Zdjęcia', name: 'photosLabel');
  }

  String get accessoryCategoryLabel {
    return Intl.message('Dodatek', name: 'accessoryCategoryLabel');
  }

  String get bagCategoryLabel {
    return Intl.message('Torba', name: 'bagCategoryLabel');
  }

  String get beachwearCategoryLabel {
    return Intl.message('Strój plażowy', name: 'beachwearCategoryLabel');
  }

  String get blouseCategoryLabel {
    return Intl.message('Bluza', name: 'blouseCategoryLabel');
  }

  String get coatCategoryLabel {
    return Intl.message('Plaszcz', name: 'coatCategoryLabel');
  }

  String get dressCategoryLabel {
    return Intl.message('Sukienka', name: 'dressCategoryLabel');
  }

  String get jacketCategoryLabel {
    return Intl.message('Kurtka', name: 'jacketCategoryLabel');
  }

  String get lightJacketLabel {
    return Intl.message('Marynarka', name: 'lightJacketLabel');
  }

  String get shoesCategoryLabel {
    return Intl.message('Buty', name: 'shoesCategoryLabel');
  }

  String get skirtCategoryLabel {
    return Intl.message('Spodnica', name: 'skirtCategoryLabel');
  }

  String get sweaterCategoryLabel {
    return Intl.message('Spodnica', name: 'sweaterCategoryLabel');
  }

  String get trousersCategoryLabel {
    return Intl.message('Spodnie', name: 'trousersCategoryLabel');
  }

  String get underwearCategoryLabel {
    return Intl.message('BIelizna', name: 'underwearCategoryLabel');
  }

  String get tshirtCategoryLabel {
    return Intl.message('Podkoszulek', name: 'tshirtCategoryLabel');
  }
}
