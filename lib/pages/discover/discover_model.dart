import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/filters/filters.dart';

class DiscoverModel {
  final Filters selectedFilters;
  final List<Item> items;

  DiscoverModel(this.selectedFilters, this.items);
}
