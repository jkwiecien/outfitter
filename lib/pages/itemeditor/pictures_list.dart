import 'package:flutter/material.dart';
import 'package:outfitter/utils/utils.dart';

class PicturesListView extends StatefulWidget {
  static const PHOTO_HEIGHT = 100.0;
  static const PHOTO_WIDTH = 130.0;
  _PicturesListViewState _state;

  _PicturesListViewState get state => _state;

  PicturesListView(List<String> urls, Function onAddPicturePressed) {
    _state = _PicturesListViewState(urls, onAddPicturePressed);
  }

  @override
  State<StatefulWidget> createState() => _state;
}

class _PicturesListViewState extends State<PicturesListView> {
  List<String> _urls;
  final Function _onAddPicturePressed;
  num uploadsInProgress = 0;

  _PicturesListViewState(this._urls, this._onAddPicturePressed);

  set urls(List<String> updatedUrls) {
    setState(() {
      uploadsInProgress--;
      _urls = updatedUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List();
    items.add(_addPhotoButton);
    for (var i = 0; i < uploadsInProgress; i++) {
      items.add(_progressIndicator());
    }

    print('URLS: $_urls');
    if (_urls != null) {
      _urls.forEach((url) {
        print('URL: $url');
        print(url);
        items.add(Container(
          decoration: BoxDecoration(
              color: ColorConfig.LIGHT_GREY, shape: BoxShape.rectangle),
          margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
          width: PicturesListView.PHOTO_WIDTH,
          height: PicturesListView.PHOTO_HEIGHT,
          child: Image.network(
            url,
            fit: BoxFit.fitHeight,
          ),
        ));
      });
    }

    return ListView(scrollDirection: Axis.horizontal, children: items);
  }

  Widget _progressIndicator() {
    return Container(
      width: PicturesListView.PHOTO_WIDTH,
      height: PicturesListView.PHOTO_HEIGHT,
      margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
      decoration: BoxDecoration(
          color: ColorConfig.LIGHT_GREY, shape: BoxShape.rectangle),
      child: Center(
          child: Container(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
              ))),
    );
  }

  Widget get _addPhotoButton {
    return Container(
      width: PicturesListView.PHOTO_WIDTH,
      height: PicturesListView.PHOTO_HEIGHT,
      margin: EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
      child: RawMaterialButton(
        fillColor: ColorConfig.LIGHT_GREY,
        elevation: 0.0,
        child: Icon(
          Icons.add_a_photo,
          color: ColorConfig.FONT_PRIMARY,
          size: 40.0,
        ),
        onPressed: () {
          _onAddPicturePressed();
        },
      ),
    );
  }

  void notifyUploadStarted() {
    setState(() {
      uploadsInProgress++;
    });
  }
}
