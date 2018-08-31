import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';

class DiscoverModel {
  ItemCategory selectedCategory = ItemCategory.fromId(CategoryId.shoes);
  List<Item> items = List();
}
