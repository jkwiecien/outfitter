import 'package:flutter/material.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/filters/filters.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/main_color_box.dart';
import 'package:outfitter/widgets/widgets.dart';

class FiltersPage extends StatefulWidget {
  final FiltersPageState _state;

  FiltersPage(this._state);

  @override
  State<StatefulWidget> createState() => _state;
}

class FiltersPageState extends State<FiltersPage> {
  final Filters _filters;

  FiltersPageState(this._filters);

  List<MainColorBox> _mainColorBoxes;

  @override
  void initState() {
    _mainColorBoxes = MainColor.allColors().map((mainColor) {
      return MainColorBox(MainColorBoxState(mainColor,
          _filters.selectedColor == mainColor, _onColorSelectionChanged));
    }).toList(growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.THEME_PRIMARY,
      appBar: AppBarFactory.flatAppBar(context,
          backgroundColor: ColorConfig.THEME_PRIMARY,
          title: S.of(context).filtersLabel,
          navigationIcon: Icons.close),
      body: Column(
        children: <Widget>[
          DividerFactory.leftCutDivider(),
          Container(
            padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.category,
                  color: ColorConfig.FONT_PRIMARY,
                ),
                SizedBox(width: PaddingSizeConfig.LARGE),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        S.of(context).categoryLabel.toUpperCase(),
                        style: TextStyleFactory.overline(),
                      ),
                      SizedBox(height: PaddingSizeConfig.SMALL),
                      Text(
                        _filters.selectedCategory
                            .getLocalisedName(context, "many")
                            .toUpperCase(),
                        style: TextStyleFactory.subtitle2(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: ColorConfig.FONT_PRIMARY),
                  onPressed: () {
                    _navigateToCategoryPicker(context);
                  },
                ),
              ],
            ),
          ),
          DividerFactory.leftCutDivider(),
          Container(
            padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.color_lens,
                    color: ColorConfig.FONT_PRIMARY,
                  ),
                  SizedBox(width: PaddingSizeConfig.LARGE),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).mainColorLabel.toUpperCase(),
                          style: TextStyleFactory.overline(),
                        ),
                        SizedBox(height: PaddingSizeConfig.SMALL),
                        Container(
                          height: 40.0,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _mainColorBoxes),
                        )
                      ],
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  _onColorSelectionChanged(MainColorBox mainColorBox) {
    if (mainColorBox.state.selected) {
      _filters.selectedColor = mainColorBox.state.mainColor;
      _mainColorBoxes.forEach((colorBox) {
        if (colorBox != mainColorBox) colorBox.state.selected = false;
      });
    } else {
      _filters.selectedColor = null;
    }
  }

  _navigateToCategoryPicker(BuildContext context) async {
    ItemCategory category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
    if (category != null) {
      setState(() {
        _filters.selectedCategory = category;
      });
    }
  }
}
