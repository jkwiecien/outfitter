import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/item.dart';
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

  List<Item> _items = List();

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
    print('WTF | Loading documents');
    Firestore.instance
        .collection('categories/shoes/items')
        .snapshots()
        .listen((querySnapshot) {
      print('WTF | Loaded items: ${querySnapshot.documents.length}');
      setState(() {
        _items = querySnapshot.documents
            .map((document) => Item.fromSnapshot(document))
            .toList();
      });
    });
  }

  List<Widget> get _itemsWidgets {
    return List.generate(100, (index) {
      return Column(
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
                Image.network(
                  'https://www.spree.co.za/imgop/w-pdp-600x803/media/catalog/product/s/p/spree170622junepicslg035.jpg',
                  height: ITEM_HEIGHT,
                  width: 3000.0,
                  fit: BoxFit.cover,
                ),
                Align(
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
                              'Takie tam buciki ale z dluzsza nazwa',
                              style: TextStyleFactory.subtitle1(
                                  color: ColorConfig.FONT_LIGHT),
                            )),
                      ),
                    ],
                  ),
                  alignment: FractionalOffset.bottomLeft,
                )
              ],
            ),
          )
        ],
      );
    });

//    _items.forEach((item) {
//      rows.add(Container(
//        color: ColorConfig.THEME_SECONDARY,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: Image.network(
//                    'https://www.spree.co.za/imgop/w-pdp-600x803/media/catalog/product/s/p/spree170622junepicslg035.jpg',
//                    fit: BoxFit.cover,
//                    height: 160.0,
//                  ),
//                ),
//              ],
//            ),
//            Text(item.name),
//            Text(item.description),
//            Text(item.brand),
//          ],
//        ),
//      ));
//    });
//    return rows;

//    List<Widget> rows = List();
//    _items.forEach((item) {
//      rows.add(Container(
//        color: ColorConfig.THEME_SECONDARY,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: Image.network(
//                    'https://www.spree.co.za/imgop/w-pdp-600x803/media/catalog/product/s/p/spree170622junepicslg035.jpg',
//                    fit: BoxFit.cover,
//                    height: 160.0,
//                  ),
//                ),
//              ],
//            ),
//            Text(item.name),
//            Text(item.description),
//            Text(item.brand),
//          ],
//        ),
//      ));
//    });
//    return rows;

    //BELOW WON'T WORK
//    return _items.map((item) {
//      Text('WTF');
//    }).toList();
  }
}
