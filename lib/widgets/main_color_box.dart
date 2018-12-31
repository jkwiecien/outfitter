import 'package:flutter/material.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/utils/utils.dart';

class MainColorBox extends StatelessWidget {
  final MainColor _mainColor;
  final bool selected;
  final OnColorTapped _onColorTapped;

  const MainColorBox(this._mainColor, this.selected, this._onColorTapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onColorTapped(_mainColor);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
        padding: EdgeInsets.all(2.0),
        decoration: selected
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(
                  width: 2.0,
                  color: ColorConfig.FONT_PRIMARY,
                ),
              )
            : BoxDecoration(),
        child: DecoratedBox(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _mainColor.color,
              border: new Border.all(
                width: 1.0,
                color: Colors.grey,
              )),
        ),
      ),
    );
  }
}

//class MainColorBoxState extends State<MainColorBox> {
//  bool _selected = false;
//
//  bool get selected => _selected;
//  final MainColor _mainColor;
//
//  MainColor get mainColor => _mainColor;
//  final OnColorChanged _onColorChanged;
//
//  MainColorBoxState(this._mainColor, this._selected, this._onColorChanged);
//
//  set selected(value) {
//    setState(() {
//      _selected = value;
//    });
//  }
//
//
//}

typedef OnColorTapped = Function(MainColor color);
