import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/models/picture.dart';

class Item {
  String id;
  DateTime dateCreated = DateTime.now();
  ItemCategory category;
  var description = '';
  var brand = '';
  MainColor mainColor;
  List<ItemPicture> pictures = List();

  Item();

  Map<String, dynamic> toMap() {
    return {
      'category': category != null ? category.toString() : null,
      'description': description,
      'brand': brand,
      'mainColor': mainColor.toString(),
      'dateCreated': dateCreated,
      'pictures': Map.fromEntries(
          pictures.map((picture) => MapEntry(picture.id, picture.url)))
    };
  }

  Item.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    dateCreated = snapshot.data['dateCreated'];
    description = snapshot.data['description'];
    brand = snapshot.data['brand'];
    mainColor = MainColor.fromString(snapshot['mainColor']);
    final picturesMap = snapshot.data['pictures'];
    if (picturesMap != null) {
      picturesMap.entries.forEach((pictureMapEntry) {
        pictures.add(ItemPicture(pictureMapEntry.key, pictureMapEntry.value));
      });
    }
  }

  void addPicture(ItemPicture picture) {
    pictures.add(picture);
    pictures = pictures.reversed.toList();
  }

  @override
  String toString() {
    return '$id created: $dateCreated \nmain color: $mainColor \ndescription: $description \nbrand: $brand \npictures: ${pictures
        .map((p) => p.id)}';
  }

  @override
  bool operator ==(other) => other is Item && id == other.id;

  @override
  int get hashCode => id != null ? id.hashCode : 0;
}
