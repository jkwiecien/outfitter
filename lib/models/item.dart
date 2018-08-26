import 'package:outfitter/models/category.dart';

enum MainColor {
  none,
  white,
  black,
  red,
  pink,
  purple,
  blue,
  green,
  yellow,
  orange,
  brown
}

class Item {
  String id;
  Category category;
  var name = '';
  var description = '';
  var brand = '';
  MainColor mainColor = MainColor.none;

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'brand': brand};
  }
}
