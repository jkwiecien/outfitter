import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/discover/model.dart';
import 'package:outfitter/pages/filters/filters.dart';
import 'package:outfitter/pages/filters/filters_page.dart';
import 'package:outfitter/pages/item/item_page.dart';
import 'package:outfitter/utils/utils.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const ITEM_HEIGHT = 200.0;
  static const ITEM_SPACING = 2.0;

  final _model = DiscoverModel();

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    var screenSize = MediaQuery.of(context).size;
    final double itemWidth = (screenSize.width / 2) - ITEM_SPACING * 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(PaddingSizeConfig.MEDIUM,
              PaddingSizeConfig.SMALL, 0.0, PaddingSizeConfig.SMALL),
          child: Row(
            children: <Widget>[
              Expanded(child: _categoryButton),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      PaddingSizeConfig.LARGE, 0.0, 0.0, 0.0),
                  child: _filtersButton)
            ],
          ),
        ),
        Expanded(
            child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / ITEM_HEIGHT),
          mainAxisSpacing: ITEM_SPACING,
          crossAxisSpacing: ITEM_SPACING,
          children: _itemsWidgets,
        ))
      ],
    );
  }

  void _loadResults() {
//    Firestore.instance
//        .collection('talks')
//        .where("topic", isEqualTo: "flutter")
//        .snapshots()
//        .listen((data) =>
//        data.documents.forEach((doc) => print(doc["title"])));
    Firestore.instance
        .collection('categories/${_model.selectedCategory.toString()}/items')
        .snapshots()
        .listen((querySnapshot) {
      print('WTF | Loaded items: ${querySnapshot.documents.length}');
      setState(() {
        _model.items = querySnapshot.documents
            .map((document) => Item.fromSnapshot(document))
            .toList();
      });
    });
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

  List<Widget> get _itemsWidgets {
    return _model.items
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

  Widget get _categoryButton => RawMaterialButton(
      child: Row(
        children: <Widget>[
          Text(
            '${S.of(context).categoryLabel.toUpperCase()}:  ${_model.selectedCategory.getLocalisedName(context, "many").toUpperCase()}',
            style: TextStyleFactory.button(),
          ),
        ],
      ),
      onPressed: () {
        _navigateToCategoryPicker(context);
      });

  Widget get _filtersButton => IconButton(
        icon: Icon(Icons.tune, color: ColorConfig.FONT_PRIMARY),
        onPressed: () {
          _navigateToFiltersPicker(context);
        },
      );

  void _navigateToCategoryPicker(BuildContext context) async {
    ItemCategory category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
    if (category != null && category != _model.selectedCategory) {
      setState(() {
        _model.selectedCategory = category;
        _loadResults();
      });
    }
  }

  void _navigateToFiltersPicker(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiltersPage(FiltersPageState(Filters())),
      ),
    );
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
