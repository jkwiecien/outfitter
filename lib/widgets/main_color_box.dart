import 'package:flutter/material.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/utils/utils.dart';

class MainColorBox extends StatefulWidget {
  final MainColorBoxState _state;

  MainColorBoxState get state => _state;

  MainColorBox(this._state);

  @override
  State<StatefulWidget> createState() => _state;
}

class MainColorBoxState extends State<MainColorBox> {
  bool _selected = false;

  bool get selected => _selected;
  final MainColor _mainColor;

  MainColor get mainColor => _mainColor;
  final Function(MainColorBox colorBox) _onSelectedChanged;

  MainColorBoxState(this._mainColor, this._selected, this._onSelectedChanged);

  set selected(value) {
    setState(() {
      _selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selected = !selected;
        _onSelectedChanged(widget);
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
