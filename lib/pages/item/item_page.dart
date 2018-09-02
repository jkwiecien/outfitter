import 'package:flutter/material.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/item/model.dart';

class ItemDetailsPage extends StatefulWidget {
  final ItemDetailsPageState _state;

  ItemDetailsPage(this._state);

  @override
  State<StatefulWidget> createState() => _state;
}

class ItemDetailsPageState extends State<ItemDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ItemDetailsModel _model;

  ItemDetailsPageState(Item item) {
    _model = ItemDetailsModel(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    );
  }
}
