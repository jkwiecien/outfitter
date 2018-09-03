import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/item/model.dart';
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
        backgroundColor: ColorConfig.BACKGROUND,
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: PHOTO_HEIGHT,
              leading: IconButton(
                  icon: Icon(Icons.close, color: ColorConfig.FONT_PRIMARY),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  height: 220.0,
                  child: _imageSectionWidget,
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Bluzałke',
                        style: TextStyleFactory.h5(),
                      ),
                      SizedBox(height: PaddingSizeConfig.SMALL),
                      _descriptionWidget,
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget get _likeWidget => IconButton(
        onPressed: () {
          //TODO
        },
        icon: Icon(
          Icons.favorite_border,
          color: ColorConfig.FONT_PRIMARY,
        ),
      );

  Widget get _imageSectionWidget => CachedNetworkImage(
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
      );

  Widget get _appBarWidget => AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[_likeWidget],
      leading: IconButton(
          icon: Icon(Icons.close, color: ColorConfig.FONT_PRIMARY),
          onPressed: () {
            Navigator.pop(context);
          }));

  Widget get _descriptionWidget {
    final item = _model.item;
    if (item.description != null && item.description.isNotEmpty) {
      return Text(item.description, style: TextStyleFactory.body1());
    } else {
      return Container();
    }
  }
}
