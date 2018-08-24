import 'package:outfitter/models/category.dart';

class Item {
  Category category = Category.fromId(CategoryId.shoes);
  var name = '';
  var description = '';
  var brand = '';

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'brand': brand};
  }
}
