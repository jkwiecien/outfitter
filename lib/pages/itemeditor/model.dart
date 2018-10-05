import 'package:flutter/material.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';

class ItemEditorModel {
  final Item item;
  final bool editMode;
  bool _privateCollection = false;

  bool get privateCollection => _privateCollection;

  set privateCollection(bool private) {
    _privateCollection = private;
    if (private) _forSale = false;
  }

  bool _forSale = false;

  bool get forSale => _forSale;

  set forSale(bool forSale) {
    _forSale = forSale;
    if (_forSale) _privateCollection = false;
  }

  ItemEditorModel(this.item, this.editMode);

  set category(ItemCategory category) {
    item.category = category;
  }

  get category => item.category;

  String getSelectedCategoryButtonTitle(BuildContext context) {
    return item.category != null
        ? item.category.getLocalisedName(context, "many").toUpperCase()
        : S.of(context).notSelectedLabel.toUpperCase();
  }
}
