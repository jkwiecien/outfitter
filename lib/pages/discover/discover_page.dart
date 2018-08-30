import 'package:flutter/material.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/widgets.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _scaffoldKey,
//      backgroundColor: ColorConfig.THEME_PRIMARY,
//      appBar: AppBarFactory.mainAppBar(context,
//          title: Translations.forKey('label_app_name', context)),
//      body: Container(
//          child: Column(
//        children: <Widget>[
//          Expanded(
//            child: RawMaterialButton(
//              shape: BeveledRectangleBorder(
//                  borderRadius:
//                      BorderRadius.only(topLeft: Radius.circular(40.0))),
//              elevation: 14.0,
//              fillColor: ColorConfig.BACKGROUND,
//              child: Text('affsfafs'),
//            ),
//          ),
//        ],
//      )),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConfig.BACKGROUND,
      appBar: AppBarFactory.mainAppBar(context,
          title: Translations.forKey('label_app_name', context)),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
        color: ColorConfig.THEME_PRIMARY,
        child: Container(
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
          child: ListView(),
        ),
      ),
    );
  }
}
