import 'package:flutter/material.dart';
import 'package:outfitter/utils.dart';

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
