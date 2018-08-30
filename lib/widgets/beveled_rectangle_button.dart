import 'package:flutter/material.dart';
import 'package:outfitter/utils/utils.dart';

class BeveledRectangleButton extends StatelessWidget {
  Function _onPressed;
  String _title;
  IconData _icon;

  BeveledRectangleButton({title, icon, Function onPressed}) {
    _title = title;
    _icon = icon;
    _onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.0,
      child: RawMaterialButton(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 4.0,
        fillColor: ColorConfig.THEME_PRIMARY,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _icon != null
                ? Icon(
                    _icon,
                    color: ColorConfig.THEME_PRIMARY_DARK,
                  )
                : SizedBox(),
            _icon != null
                ? SizedBox(width: PaddingSizeConfig.MEDIUM)
                : SizedBox(),
            Text(
              _title != null ? _title.toUpperCase() : '',
              style: TextStyleFactory.button(),
            ),
          ],
        ),
        onPressed: () {
          _onPressed();
        },
      ),
    );
  }
}

class BeveledRectangleProgressButton extends StatefulWidget {
  final BeveledRectangleProgressButtonState _state;

  BeveledRectangleProgressButton(this._state, {String title}) {
    _state._title = title;
  }

  @override
  State<StatefulWidget> createState() => _state;
}

class BeveledRectangleProgressButtonState
    extends State<BeveledRectangleProgressButton> {
  String _title;
  IconData _iconData;
  Function _onPressed;
  bool _progress = false;

  set progress(bool value) {
    setState(() {
      _progress = value;
    });
  }

  BeveledRectangleProgressButtonState({iconData, Function onPressed}) {
    _iconData = iconData;
    _onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.0,
      child: RawMaterialButton(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 4.0,
        fillColor: ColorConfig.THEME_PRIMARY,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _graphicContainer(),
            Text(
              _title.toUpperCase(),
              style: TextStyleFactory.button(),
            ),
          ],
        ),
        onPressed: () {
          _onPressed();
        },
      ),
    );
  }

  Widget _graphicContainer() {
    if (_progress) {
      return Container(
          width: 18.0,
          height: 18.0,
          margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.MEDIUM, 0.0),
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ));
    } else if (_iconData != null) {
      return Container(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.MEDIUM, 0.0),
        child: Icon(
          _iconData,
          color: ColorConfig.THEME_PRIMARY_DARK,
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
