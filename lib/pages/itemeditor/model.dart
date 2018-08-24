import 'package:flutter/material.dart';
import 'package:outfitter/model/category.dart';
import 'package:outfitter/translations.dart';

class ItemEditorModel {
  Category selectedCategory;

  ItemEditorModel(this.selectedCategory);

  String getSelectedCategoryButtonTitle(BuildContext context) {
    return selectedCategory != null ? selectedCategory.getLocalisedName(context) : Translations.forKey('button_title_category', context);
  }

}
