import 'package:flutter/material.dart';
import 'package:outfitter/translations.dart';

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
  }

  Category.fromId(CategoryId enumId) {
    categoryId = enumId;
  }

  String getLocalisedName(BuildContext context) {
    return Translations.of(context).text(this.toString());
  }

  @override
  String toString() {
    return categoryId.toString().replaceAll("CategoryId.", "");
  }
}
