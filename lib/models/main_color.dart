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

  MainColor.white() {
    this.id = MainColorId.white;
  }

  MainColor.grey() {
    this.id = MainColorId.grey;
  }

  MainColor.black() {
    this.id = MainColorId.black;
  }

  MainColor.red() {
    this.id = MainColorId.red;
  }

  MainColor.pink() {
    this.id = MainColorId.pink;
  }

  MainColor.purple() {
    this.id = MainColorId.purple;
  }

  MainColor.blue() {
    this.id = MainColorId.blue;
  }

  MainColor.green() {
    this.id = MainColorId.green;
  }

  MainColor.yellow() {
    this.id = MainColorId.yellow;
  }

  MainColor.orange() {
    this.id = MainColorId.orange;
  }

  MainColor.brown() {
    this.id = MainColorId.brown;
  }

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

  static List<MainColor> allColors() {
    return [
      MainColor.white(),
      MainColor.grey(),
      MainColor.black(),
      MainColor.red(),
      MainColor.pink(),
      MainColor.purple(),
      MainColor.blue(),
      MainColor.green(),
      MainColor.yellow(),
      MainColor.orange(),
      MainColor.brown()
    ];
  }

  @override
  String toString() {
    return id.toString().replaceAll("MainColorId.", "");
  }

  @override
  bool operator ==(other) => other is MainColor && id == other.id;

  @override
  int get hashCode => id != null ? id.hashCode : 0;
}
