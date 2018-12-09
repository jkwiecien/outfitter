import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/item/item_page.dart';
import 'package:outfitter/pages/wardrobe/wardrobe_model.dart';
import 'package:outfitter/utils/utils.dart';

class WardrobePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  static const ITEM_HEIGHT = 100.0;
  static const ITEM_SPACING = 2.0;

  var _model = WardrobeModel();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: ValueKey<String>('WardrobePage'),
      primary: true,
      children: ItemCategory.allCategories()
          .map((category) => categorySection(context, category))
          .toList(),
    );
  }

  void _loadData() {
    final user = application.user;
    ItemCategory.allCategories().forEach((category) {
      Query query = Firestore.instance
          .collection('categories/${category.toString()}/items')
          .where('visibility_status', isGreaterThan: Status.STATUS_ARCHIVED)
          .where('user_id', isEqualTo: user.uid);

      query.snapshots().listen((querySnapshot) {
        final items = querySnapshot.documents
            .map((document) => Item.fromSnapshot(document))
            .toList();
        _onCategoryLoaded(category, items);
      });
    });
  }

  void _onCategoryLoaded(ItemCategory category, List<Item> items) {
    setState(() {
      _model.addItems(items);
    });
  }

  Widget categorySection(BuildContext context, ItemCategory category) {
    var screenSize = MediaQuery.of(context).size;
    final double itemWidth = (screenSize.width / 4) - ITEM_SPACING * 2;

    var items = _model.getItems(category);

    if (items.length > 0) {
      var firstItems = items.take(3).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(PaddingSizeConfig.MEDIUM),
            child: Text(
                category.getLocalisedName(context, 'many').toUpperCase(),
                style: TextStyleFactory.h6()),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            shrinkWrap: true,
            childAspectRatio: (itemWidth / ITEM_HEIGHT),
            mainAxisSpacing: ITEM_SPACING,
            crossAxisSpacing: ITEM_SPACING,
            children: _itemsWidgets(firstItems),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  List<Widget> _itemsWidgets(List<Item> items) {
    return items
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
                            _descriptionSectionWidget(item),
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

  Widget _descriptionSectionWidget(Item item) {
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

  void _navigateToItemDetails(BuildContext context, Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(ItemDetailsPageState(item)),
      ),
    );
  }
}
