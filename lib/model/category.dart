import 'package:flutter/material.dart';

import '../translations.dart';

enum CategoryId {
  accessory,
  bag,
  beachwear,
  blouse,
  coat,
  dress,
  jacket,
  light_jacket,
  shirt,
  shoes,
  skirt,
  sweater,
  trousers,
  underwear
}

class Category {
  CategoryId categoryId;

  Category(this.categoryId);

  Category.fromString(String categoryIdString) {
    categoryId = CategoryId.values.firstWhere(
        (c) => c.toString() == 'CategoryId.$categoryIdString',
        orElse: () => null);
    print("$categoryId created from string: $categoryIdString");
  }

  String getLocalisedName(BuildContext context) {
    String translationKey = categoryId.toString().replaceAll("CategoryId.", "");
    return Translations.of(context).text(translationKey);
  }
}
