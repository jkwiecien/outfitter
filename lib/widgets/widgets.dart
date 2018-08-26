import 'package:flutter/material.dart';
import 'package:outfitter/utils/utils.dart';

class AppBarFactory {
  static const _defaultNavigationIcon = Icons.arrow_back;
  static const _defaultBackgroundColor = Colors.transparent;

  static AppBar flatAppBar(BuildContext context,
      {String title: '',
      IconData navigationIcon: _defaultNavigationIcon,
      Color backgroundColor: _defaultBackgroundColor}) {
    return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(navigationIcon, color: ColorConfig.FONT_PRIMARY),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(title.toUpperCase(),
            style: TextStyle(
                color: ColorConfig.FONT_PRIMARY,
                decorationColor: ColorConfig.FONT_PRIMARY,
                fontWeight: FontWeightConfig.MEDIUM,
                fontSize: FontSizeConfig.LARGE)));
  }
}

class DividerFactory {
  static Widget leftCutDivider({offset: 60.0}) {
    return Container(
      margin: EdgeInsets.fromLTRB(offset, 0.0, 0.0, 0.0),
      padding: EdgeInsets.fromLTRB(
          0.0, PaddingSizeConfig.LARGE, 0.0, PaddingSizeConfig.LARGE),
      child: Container(height: 1.0, color: ColorConfig.DIVIDER),
    );
  }
}
