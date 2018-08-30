import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/models/picture.dart';

class Item {
  String id;
  Category category;
  var name = '';
  var description = '';
  var brand = '';
  MainColor mainColor;
  List<ItemPicture> pictures = List();
  DateTime dateCreated = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category != null ? category.toString() : null,
      'name': name,
      'description': description,
      'brand': brand,
      'pictures': Map.fromEntries(
          pictures.map((picture) => MapEntry(picture.id, picture.url)))
    };
  }

  void addPicture(ItemPicture picture) {
    pictures.add(picture);
    pictures = pictures.reversed.toList();
  }
}
