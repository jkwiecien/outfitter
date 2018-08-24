import 'package:flutter/material.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/translations.dart';

class ItemEditorModel {
  final Item item = Item();

  set category(Category category) {
    item.category = category;
  }

  get category => item.category;

  String getSelectedCategoryButtonTitle(BuildContext context) {
    return item.category != null
        ? item.category.getLocalisedName(context)
        : Translations.forKey('button_title_category', context);
  }
}
