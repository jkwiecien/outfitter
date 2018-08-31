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

class ItemCategory {
  CategoryId categoryId;

  ItemCategory(this.categoryId);

  ItemCategory.fromString(String categoryIdString) {
    categoryId = CategoryId.values.firstWhere(
        (c) => c.toString() == 'CategoryId.$categoryIdString',
        orElse: () => null);
  }

  ItemCategory.fromId(CategoryId enumId) {
    categoryId = enumId;
  }

  String getLocalisedName(BuildContext context) {
    return Translations.of(context).text(this.toString());
  }

  @override
  String toString() {
    return categoryId.toString().replaceAll("CategoryId.", "");
  }

  @override
  bool operator ==(other) =>
      other is ItemCategory && categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;
}
