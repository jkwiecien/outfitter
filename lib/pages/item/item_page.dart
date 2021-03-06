import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/item/model.dart';
import 'package:outfitter/pages/itemeditor/item_wizard.dart';
import 'package:outfitter/utils/utils.dart';

class ItemDetailsPage extends StatefulWidget {
  final ItemDetailsPageState _state;

  ItemDetailsPage(this._state);

  @override
  State<StatefulWidget> createState() => _state;
}

class ItemDetailsPageState extends State<ItemDetailsPage> {
  static const PHOTO_HEIGHT = 460.0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ItemDetailsModel _model;

  ItemDetailsPageState(Item item) {
    _model = ItemDetailsModel(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[_imageSectionWidget, _appBar, _detailsWidget],
        ));
  }

  Widget get _detailsWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
          constraints:
              const BoxConstraints(minWidth: double.infinity, maxHeight: 220.0),
          child: Padding(
            padding: const EdgeInsets.only(
                left: PaddingSizeConfig.SMALL, right: PaddingSizeConfig.SMALL),
            child: Container(
              color: ColorConfig.BACKGROUND,
              child: Padding(
                padding: const EdgeInsets.all(PaddingSizeConfig.MEDIUM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _model.item.getLocalisedDisplayName(context),
                      style: TextStyleFactory.h5(),
                    ),
                    _descriptionWidget
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _createActionButton(IconData iconData, Function onPressed) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: IconButton(
          iconSize: 20.0,
          icon: Icon(iconData, color: ColorConfig.FONT_PRIMARY),
          onPressed: onPressed),
    );
  }

  Widget get _imageSectionWidget => FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 0.8,
      child: Hero(
        tag: _model.item,
        child: CachedNetworkImage(
          imageUrl: _model.item.pictures.first.url,
          height: PHOTO_HEIGHT,
          width: 3000.0,
          fit: BoxFit.cover,
          placeholder: Center(
              child: Container(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ))),
        ),
      ));

  Widget get _descriptionWidget {
    final item = _model.item;
    if (item.description != null && item.description.isNotEmpty) {
      return Text(item.description, style: TextStyleFactory.body1());
    } else {
      return Container();
    }
  }

  Widget get _appBar {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _createActionButton(Icons.close, () {
              Navigator.pop(context);
            }),
          )),
    );
  }

  void _navigateToItemEditor(BuildContext context) async {
    Item updatedItem = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ItemWizardPage(ItemWizardPageState(_model.item))));
    if (updatedItem != null) {
      setState(() {
        _model.item = updatedItem;
      });
    }
  }
}
