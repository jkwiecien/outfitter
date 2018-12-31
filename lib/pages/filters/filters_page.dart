import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/app_state.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/filters/filters.dart';
import 'package:outfitter/redux/actions.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';
import 'package:outfitter/widgets/main_color_box.dart';
import 'package:outfitter/widgets/widgets.dart';
import 'package:redux/redux.dart';

class FiltersPage extends StatelessWidget {
  final Store<AppState> store;

  const FiltersPage(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Filters>(
      converter: (store) => store.state.discoverFilters,
      builder: (context, filters) => Scaffold(
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
                              filters.category
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
                                    children: _mainColorBoxes()),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
                DividerFactory.leftCutDivider(),
                _visibilityAndTradeSection(context),
                Padding(
                  padding: const EdgeInsets.all(PaddingSizeConfig.LARGE),
                  child: BeveledRectangleProgressButton(
                    BeveledRectangleProgressButtonState(
                        buttonColor: ColorConfig.THEME_SECONDARY,
                        onPressed: () {
                          Navigator.pop(context, filters);
                        }),
                    title: S.of(context).applyFiltersButtonTitle,
                  ),
                )
              ],
            ),
          ),
    );
  }

  Widget _visibilityAndTradeSection(BuildContext context) => Container(
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
                            value: store.state.discoverFilters.forSaleOnly,
                            onChanged: (value) => _onForSaleOnlyChanged(value)),
                      ],
                    )
                  ],
                ),
              ),
            ]),
      );

  _onForSaleOnlyChanged(bool forSaleOnly) {
    debugPrint("For sale only changed: $forSaleOnly");
    store.dispatch(FiltersChangedAction(
        store.state.discoverFilters.copy(newForSaleOnly: forSaleOnly)));
  }

  _navigateToCategoryPicker(BuildContext context) async {
    ItemCategory category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
    //TODO
//    if (category != null) {
//      setState(() {
//        _filters.category = category;
//      });
//    }
  }

  List<MainColorBox> _mainColorBoxes() => MainColor.allColors().map((boxColor) {
        var selected = store.state.discoverFilters.color == boxColor;
        return MainColorBox(
            boxColor, selected, (color) => _onColorTapped(color));
      }).toList(growable: false);

  _onColorTapped(MainColor color) {
    debugPrint("Color tapped: $color");
    var newColor = color == store.state.discoverFilters.color
        ? MainColor.fromId(MainColorId.none)
        : color;
    store.dispatch(FiltersChangedAction(
        store.state.discoverFilters.copy(newColor: newColor)));
  }
}
