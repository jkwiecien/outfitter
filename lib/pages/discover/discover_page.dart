import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/discover/model.dart';
import 'package:outfitter/pages/itemeditor/item_wizard.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/widgets.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const ITEM_HEIGHT = 200.0;
  static const ITEM_SPACING = 2.0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _model = DiscoverModel();

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double itemWidth = (screenSize.width / 2) - ITEM_SPACING * 2;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConfig.THEME_PRIMARY,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: ColorConfig.THEME_PRIMARY_DARK,
          onPressed: () {
            _navigateToItemCreator(context);
          }),
      appBar: AppBarFactory.mainAppBar(context,
          title: Translations.forKey('label_app_name', context)),
      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
        padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
        decoration: ShapeDecoration(
            color: ColorConfig.BACKGROUND,
            shape: BeveledRectangleBorder(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(40.0))),
            shadows: List.of([
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: Offset(5.0, 5.0))
            ])),
        child: Column(
          children: <Widget>[
            Container(
              height: 40.0,
              margin: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 20.0),
              child: RawMaterialButton(
                  child: Text(
                    _model.selectedCategory
                        .getLocalisedName(context)
                        .toUpperCase(),
                    style: TextStyleFactory.button(),
                  ),
                  onPressed: () {
                    _navigateToCategoryPicker(context);
                  }),
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
        ),
      ),
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
      return Image.network(
        item.pictures.first.url,
        height: ITEM_HEIGHT,
        width: 3000.0,
        fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }

  Widget _descriptionSectionWidget(Item item) {
    if (item.description != null && item.description.isNotEmpty) {
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
                    item.description,
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
        .map((item) => Column(
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
            ))
        .toList();
  }

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

  void _navigateToItemCreator(BuildContext context) async {
    Item item = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemWizardPage()));
    if (item != null) {
      //TODO
    }
  }
}
