import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';

class WardrobeModel {
  List<Item> _items = List();

  void addItems(List<Item> newItems) {
    _items.addAll(newItems);
  }

  Map<ItemCategory, List<Item>> getItemsMap() {
    final map = Map<ItemCategory, List<Item>>();
    ItemCategory.allCategories().forEach((category) {
      final itemsInCategory =
          _items.where((item) => item.category == category).toList();
      map[category] = itemsInCategory;
    });
    return map;
  }

  List<Item> getItems(ItemCategory category) {
    return _items.where((item) => item.category == category).toList();
  }
}
