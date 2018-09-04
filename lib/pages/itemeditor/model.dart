import 'package:flutter/material.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';

class ItemEditorModel {
  final Item item = Item();

  set category(ItemCategory category) {
    item.category = category;
  }

  get category => item.category;

  String getSelectedCategoryButtonTitle(BuildContext context) {
    return item.category != null
        ? item.category.getLocalisedName(context, "many").toUpperCase()
        : S.of(context).notSelectedLabel.toUpperCase();
  }

  bool isEdit() => item.id != null;
}
