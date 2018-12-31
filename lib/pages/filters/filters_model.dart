import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/pages/filters/filters.dart';

class FiltersModel {
  MainColor color;
  ItemCategory category;
  bool forSaleOnly = false;

  FiltersModel.fromFilters(Filters filters) {
    color = filters.color;
    category = filters.category;
    forSaleOnly = filters.forSaleOnly;
  }
}
