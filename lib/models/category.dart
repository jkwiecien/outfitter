import 'package:flutter/material.dart';
import 'package:outfitter/generated/i18n.dart';

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
  underwear,
  tshirt
}

@immutable
class ItemCategory {
  final CategoryId categoryId;

  ItemCategory(this.categoryId);

  ItemCategory.fromString(String categoryIdString)
      : categoryId = CategoryId.values.firstWhere(
            (c) => c.toString() == 'CategoryId.$categoryIdString',
            orElse: () => null);

  ItemCategory.fromId(CategoryId categoryId) : categoryId = categoryId;

  static List<ItemCategory> allCategories() {
    return CategoryId.values.map((id) {
      return ItemCategory(id);
    }).toList();
  }

  String getLocalisedName(BuildContext context, String howMany) {
    switch (categoryId) {
      case CategoryId.accessory:
        return S.of(context).accessoryCategory(howMany);
      case CategoryId.bag:
        return S.of(context).bagCategory(howMany);
      case CategoryId.beachwear:
        return S.of(context).beachwearCategory(howMany);
      case CategoryId.blouse:
        return S.of(context).blouseCategory(howMany);
      case CategoryId.coat:
        return S.of(context).coatCategory(howMany);
      case CategoryId.dress:
        return S.of(context).dressCategory(howMany);
      case CategoryId.jacket:
        return S.of(context).jacketCategory(howMany);
      case CategoryId.light_jacket:
        return S.of(context).lightJacketCategory(howMany);
      case CategoryId.shirt:
        return S.of(context).shirtCategory(howMany);
      case CategoryId.shoes:
        return S.of(context).shoesCategory(howMany);
      case CategoryId.skirt:
        return S.of(context).skirtCategory(howMany);
      case CategoryId.sweater:
        return S.of(context).sweaterCategory(howMany);
      case CategoryId.trousers:
        return S.of(context).trousersCategory(howMany);
      case CategoryId.underwear:
        return S.of(context).underwearCategory(howMany);
      case CategoryId.tshirt:
        return S.of(context).tshirtCategory(howMany);
    }
    return "";
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
