import 'package:flutter/material.dart';

enum MainColorId {
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

class MainColor {
  MainColorId id;

  MainColor(this.id);

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

  MainColor.fromString(String mainColorIdString) {
    id = MainColorId.values.firstWhere(
        (c) => c.toString() == 'MainColorId.$mainColorIdString',
        orElse: () => null);
  }

  @override
  String toString() {
    return id.toString().replaceAll("MainColorId.", "");
  }
}
