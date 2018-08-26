import 'package:outfitter/models/category.dart';

class Item {
  String id;
  Category category;
  var name = '';
  var description = '';
  var brand = '';

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'brand': brand};
  }
}
