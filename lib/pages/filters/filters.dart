import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';

@immutable
class Filters {
  final MainColor color;
  final ItemCategory category;
  final bool forSaleOnly;

  Filters.createDefault()
      : color = MainColor.fromId(MainColorId.none),
        category = ItemCategory.fromId(CategoryId.shoes),
        forSaleOnly = false;

  Filters.create({color: MainColor, category: ItemCategory, forSaleOnly: bool})
      : color = color,
        category = category,
        forSaleOnly = forSaleOnly;

  Filters copy(
      {newColor: MainColor, newCategory: ItemCategory, newForSaleOnly: bool}) {
    var nonNullColor = newColor is MainColor ? newColor : color;
    var nonNullCategory = newCategory is ItemCategory ? newCategory : category;
    var nonNullForSaleOnly =
        newForSaleOnly is bool ? newForSaleOnly : forSaleOnly;

    return Filters.create(
        color: nonNullColor,
        category: nonNullCategory,
        forSaleOnly: nonNullForSaleOnly);
  }

  Map<String, dynamic> toJson() => {
        'color': color.toString(),
        'category': category.toString(),
        'forSaleOnly': forSaleOnly
      };

  Filters.fromJson(Map<String, dynamic> json)
      : color = MainColor.fromString(json['color']),
        category = ItemCategory.fromString(json['category']),
        forSaleOnly = json['forSaleOnly'];

  @override
  String toString() {
    return "color: $color, category: $category, sale only: $forSaleOnly";
  }
}
