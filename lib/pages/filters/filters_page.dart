import 'package:flutter/material.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/filters/filters.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';
import 'package:outfitter/widgets/main_color_box.dart';
import 'package:outfitter/widgets/widgets.dart';

class FiltersPage extends StatefulWidget {
  final FiltersPageState _state;

  FiltersPage(this._state);

  @override
  State<StatefulWidget> createState() => _state;
}

class FiltersPageState extends State<FiltersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Filters _filters;

  FiltersPageState(this._filters);

  List<MainColorBox> _mainColorBoxes;

  @override
  void initState() {
    _mainColorBoxes = MainColor.allColors().map((mainColor) {
      return MainColorBox(MainColorBoxState(
          mainColor, _filters.color == mainColor, _onColorSelectionChanged));
    }).toList(growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                        _filters.category
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
          ),
          DividerFactory.leftCutDivider(),
          _visibilityAndTradeSection,
          Padding(
            padding: const EdgeInsets.all(PaddingSizeConfig.LARGE),
            child: BeveledRectangleProgressButton(
              BeveledRectangleProgressButtonState(
                  buttonColor: ColorConfig.THEME_SECONDARY,
                  onPressed: () {
                    Navigator.pop(context, _filters);
                  }),
              title: S.of(context).applyFiltersButtonTitle,
            ),
          )
        ],
      ),
    );
  }

  Widget get _visibilityAndTradeSection => Container(
        padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                color: ColorConfig.FONT_PRIMARY,
              ),
              SizedBox(width: PaddingSizeConfig.LARGE),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).visibilityAndTradeLabel.toUpperCase(),
                      style: TextStyleFactory.overline(),
                    ),
                    SizedBox(height: PaddingSizeConfig.SMALL),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(S.of(context).forSaleOnlyLabel,
                              style: TextStyleFactory.subtitle1()),
                        ),
                        Switch(
                            value: _filters.forSaleOnly,
                            onChanged: _onForSaleOnlyChanged),
                      ],
                    )
                  ],
                ),
              ),
            ]),
      );

  _onForSaleOnlyChanged(bool value) {
    setState(() {
      _filters.forSaleOnly = value;
    });
  }

  _onColorSelectionChanged(MainColorBox mainColorBox) {
    if (mainColorBox.state.selected) {
      _filters.color = mainColorBox.state.mainColor;
      _mainColorBoxes.forEach((colorBox) {
        if (colorBox != mainColorBox) colorBox.state.selected = false;
      });
    } else {
      _filters.color = null;
    }
  }

  _navigateToCategoryPicker(BuildContext context) async {
    ItemCategory category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
    if (category != null) {
      setState(() {
        _filters.category = category;
      });
    }
  }
}
