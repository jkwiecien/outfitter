import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';

class Item {
  String id;
  Category category;
  var name = '';
  var description = '';
  var brand = '';
  MainColor mainColor;
  List<String> pictures = List();

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'brand': brand};
  }

  void addPicture(String url) {
    pictures.add(url);
    pictures = pictures.reversed.toList();
  }
}
