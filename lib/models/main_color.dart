import 'package:flutter/material.dart';

enum MainColorId {
  none,
  white,
  grey,
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

@immutable
class MainColor {
  final MainColorId id;

  MainColor.fromId(this.id);

  Color get color {
    switch (id) {
      case MainColorId.white:
        return Colors.white;
      case MainColorId.grey:
        return Colors.grey;
      case MainColorId.black:
        return Colors.black;
      case MainColorId.red:
        return Colors.red;
      case MainColorId.pink:
        return Colors.pink;
      case MainColorId.purple:
        return Colors.purple;
      case MainColorId.blue:
        return Colors.blue;
      case MainColorId.green:
        return Colors.green;
      case MainColorId.yellow:
        return Colors.yellow;
      case MainColorId.orange:
        return Colors.orange;
      case MainColorId.brown:
        return Colors.brown;
      default:
        return Colors.transparent;
    }
  }

  MainColor.fromString(String mainColorIdString)
      : id = MainColorId.values.firstWhere(
            (c) => c.toString() == 'MainColorId.$mainColorIdString',
            orElse: () => null);

  static List<MainColor> allColors() {
    return [
      MainColor.fromId(MainColorId.white),
      MainColor.fromId(MainColorId.grey),
      MainColor.fromId(MainColorId.black),
      MainColor.fromId(MainColorId.red),
      MainColor.fromId(MainColorId.pink),
      MainColor.fromId(MainColorId.purple),
      MainColor.fromId(MainColorId.blue),
      MainColor.fromId(MainColorId.green),
      MainColor.fromId(MainColorId.yellow),
      MainColor.fromId(MainColorId.orange),
      MainColor.fromId(MainColorId.brown)
    ];
  }

  @override
  String toString() {
    return id.toString().replaceAll("MainColorId.", "");
  }

  @override
  bool operator ==(other) => other is MainColor && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
