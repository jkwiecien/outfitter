import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';

class Filters {
  MainColor selectedColor;
  ItemCategory selectedCategory = ItemCategory.fromId(CategoryId.shoes);
}
