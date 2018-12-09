import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/models/picture.dart';

class Status {
  static const int STATUS_ARCHIVED = 0;
  static const int SOLD = 1;
  static const int PRIVATE = 2;
  static const int PUBLIC = 3;
  static const int FOR_SALE = 4;
}

class Item {
  String id;
  String userId;
  DateTime dateCreated = DateTime.now();
  DateTime dateBought;
  ItemCategory category;
  var name = '';
  var description = '';
  var brand = '';
  String size;
  MainColor mainColor;
  List<ItemPicture> pictures = List();
  num price = 0.0;
  var status = Status.PUBLIC;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'category': category.toString(),
      'description': description,
      'brand': brand,
      'size': size,
      'mainColor': mainColor.toString(),
      'dateCreated': dateCreated,
      'dateBought': dateBought,
      'status': status,
      'price': price,
      'pictures': Map.fromEntries(
          pictures.map((picture) => MapEntry(picture.id, picture.url)))
    };
  }

  Item.newInstance() {
    userId = application.user.uid;
    dateCreated = DateTime.now();
  }

  Item.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    userId = snapshot.data['user_id'];
    category = ItemCategory.fromString(snapshot.data['category']);
    name = snapshot.data['name'];
    dateCreated = snapshot.data['date_created'];
    dateCreated = snapshot.data['date_bought'];
    description = snapshot.data['description'];
    brand = snapshot.data['brand'];
    size = snapshot.data['size'];
    mainColor = MainColor.fromString(snapshot['mainColor']);
    status = snapshot.data['status'];
    final picturesMap = snapshot.data['pictures'];
    if (picturesMap != null) {
      picturesMap.entries.forEach((pictureMapEntry) {
        pictures.add(ItemPicture(pictureMapEntry.key, pictureMapEntry.value));
      });
    }
  }

  String getLocalisedDisplayName(BuildContext context) {
    if (name != null && name.isNotEmpty) {
      return name;
    } else if (brand != null && brand.isNotEmpty) {
      return '${category.getLocalisedName(context, "1")} $brand';
    } else {
      return category.getLocalisedName(context, "1");
    }
  }

  void addPicture(ItemPicture picture) {
    pictures.add(picture);
    pictures = pictures.reversed.toList();
  }

  @override
  String toString() {
    return '$id created: $dateCreated \nmain color: $mainColor \ndescription: $description \nbrand: $brand \npictures: ${pictures.map((p) => p.id)}';
  }

  @override
  bool operator ==(other) => other is Item && id == other.id;

  @override
  int get hashCode => id != null ? id.hashCode : 0;
}
