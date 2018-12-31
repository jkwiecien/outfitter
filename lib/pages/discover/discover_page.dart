import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outfitter/models/app_state.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/discover/discover_model.dart';
import 'package:outfitter/pages/filters/filters.dart';
import 'package:outfitter/pages/filters/filters_page.dart';
import 'package:outfitter/pages/item/item_page.dart';
import 'package:outfitter/redux/actions.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:redux/redux.dart';

class DiscoverPage extends StatelessWidget {
  static const ITEM_HEIGHT = 200.0;
  static const ITEM_SPACING = 2.0;

  final Store<AppState> store;

  const DiscoverPage(this.store);

  List<Item> get _items => store.state.discoverItems;

  Filters get _selectedFilters => store.state.discoverFilters;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    var screenSize = MediaQuery.of(context).size;
    final double itemWidth = (screenSize.width / 2) - ITEM_SPACING * 2;

    return StoreConnector<AppState, DiscoverModel>(
        converter: (store) => DiscoverModel(
            store.state.discoverFilters, store.state.discoverItems),
        builder: (context, model) => Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(PaddingSizeConfig.MEDIUM,
                        PaddingSizeConfig.SMALL, 0.0, PaddingSizeConfig.SMALL),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: _selectedFiltersSection(context)),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                PaddingSizeConfig.LARGE, 0.0, 0.0, 0.0),
                            child: _filtersButton(context))
                      ],
                    ),
                  ),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / ITEM_HEIGHT),
                    mainAxisSpacing: ITEM_SPACING,
                    crossAxisSpacing: ITEM_SPACING,
                    children: _itemsWidgets(context),
                  ))
                ],
              ),
            ));
  }

  Widget _primaryPictureWidget(Item item) {
    if (item.pictures.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: item.pictures.first.url,
        height: ITEM_HEIGHT,
        width: 3000.0,
        fit: BoxFit.cover,
        placeholder: Center(
            child: Container(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                ))),
      );
    } else {
      return Container();
    }
  }

  Widget _descriptionSectionWidget(BuildContext context, Item item) {
    if ((item.name != null && item.name.isNotEmpty) ||
        (item.brand != null && item.brand.isNotEmpty)) {
      return Align(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      PaddingSizeConfig.SMALL,
                      PaddingSizeConfig.LARGE,
                      PaddingSizeConfig.SMALL,
                      PaddingSizeConfig.SMALL),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConfig.THEME_PRIMARY_DARK,
                        Colors.transparent
                      ],
                      stops: [0.0, 0.9],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    item.getLocalisedDisplayName(context),
                    style: TextStyleFactory.subtitle1(
                        color: ColorConfig.FONT_LIGHT),
                  )),
            ),
          ],
        ),
        alignment: FractionalOffset.bottomLeft,
      );
    } else {
      return Container();
    }
  }

  List<Widget> _itemsWidgets(BuildContext context) {
    return _items
        .map((item) => Hero(
              tag: item,
              child: Material(
                child: InkWell(
                  onTap: () {
                    _navigateToItemDetails(context, item);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ITEM_HEIGHT,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 3000.0,
                              height: ITEM_HEIGHT,
                              color: ColorConfig.THEME_SECONDARY,
                            ),
                            _primaryPictureWidget(item),
                            _descriptionSectionWidget(context, item),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  Widget _selectedFiltersSection(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          _selectedFilters.category
              .getLocalisedName(context, "many")
              .toUpperCase(),
          style: TextStyleFactory.button(),
        ),
        Container(width: PaddingSizeConfig.MEDIUM),
        _colorFilterWidget,
        _forSaleOnlyFilterWidget(context)
      ],
    );
  }

  Widget get _colorFilterWidget => _selectedFilters.color != null
      ? Container(
          width: 24.0,
          height: 24.0,
          margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
          padding: EdgeInsets.all(2.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedFilters.color.color,
                border: new Border.all(
                  width: 1.0,
                  color: Colors.grey,
                )),
          ))
      : Container();

  Widget _forSaleOnlyFilterWidget(BuildContext context) =>
      _selectedFilters.forSaleOnly
          ? Container(
              width: 24.0,
              height: 24.0,
              margin:
                  EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
              child: Icon(
                Icons.monetization_on,
                color: ColorConfig.FONT_PRIMARY,
              ),
            )
          : Container();

  Widget _filtersButton(BuildContext context) => IconButton(
        icon: const Icon(Icons.tune, color: ColorConfig.FONT_PRIMARY),
        onPressed: () {
          _navigateToFiltersPicker(context);
        },
      );

  void _navigateToFiltersPicker(BuildContext context) async {
    Filters filters = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiltersPage(store),
      ),
    );
    if (filters != null) {
      store.dispatch(FetchDiscoverListAction());
    }
  }

  void _navigateToItemDetails(BuildContext context, Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(ItemDetailsPageState(item)),
      ),
    );
  }
}
