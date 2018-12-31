import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/models/picture.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/itemeditor/brand_form.dart';
import 'package:outfitter/pages/itemeditor/description_form.dart';
import 'package:outfitter/pages/itemeditor/model.dart';
import 'package:outfitter/pages/itemeditor/name_form.dart';
import 'package:outfitter/pages/itemeditor/pictures_list.dart';
import 'package:outfitter/pages/itemeditor/price_form.dart';
import 'package:outfitter/pages/itemeditor/size_form.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';
import 'package:outfitter/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class ItemWizardPage extends StatefulWidget {
  ItemWizardPageState _state;

  ItemWizardPage(this._state);

  @override
  State<StatefulWidget> createState() => _state;
}

class ItemWizardPageState extends State<ItemWizardPage> {
  ItemEditorModel _model;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ItemNameForm _nameForm;
  ItemDescriptionForm _descriptionForm;
  ItemBrandForm _brandForm;
  ItemSizeForm _sizeForm;

//  List<MainColorBox> _mainColorBoxes;
  PicturesListView _picturesListView;
  BeveledRectangleProgressButtonState _saveButtonState;

  ItemWizardPageState(Item item) {
    _model = ItemEditorModel(item, item.id != null);
  }

  @override
  void initState() {
    _nameForm =
        ItemNameForm(ItemNameFormState(_model.item.name, onTextChanged: (text) {
      _model.item.name = text;
    }));

    _descriptionForm = ItemDescriptionForm(ItemDescriptionFormState(
        _model.item.description, onTextChanged: (text) {
      _model.item.description = text;
    }));

    _brandForm = ItemBrandForm(
        ItemBrandFormState(_model.item.brand, onTextChanged: (text) {
      _model.item.brand = text;
    }));

    _sizeForm =
        ItemSizeForm(ItemSizeFormState(_model.item.size, onTextChanged: (text) {
      _model.item.size = text;
    }));

//    _mainColorBoxes = MainColor.allColors().map((mainColor) {
//      return MainColorBox(MainColorBoxState(mainColor,
//          _model.item.mainColor == mainColor, _onColorSelectionChanged));
//    }).toList(growable: false);

    _picturesListView =
        PicturesListView(_model.item.pictures, _addImageFromGallery);

    _saveButtonState = BeveledRectangleProgressButtonState(
        iconData: Icons.save,
        onPressed: () {
          _saveItem(context);
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConfig.BACKGROUND,
      appBar: AppBarFactory.flatAppBar(context,
          navigationIcon: Icons.close,
          title: _model.editMode
              ? S.of(context).editItemPageTitle
              : S.of(context).createItemPageTitle),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DividerFactory.leftCutDivider(),
            Container(
              padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.category,
                    color: ColorConfig.FONT_PRIMARY,
                  ),
                  SizedBox(width: PaddingSizeConfig.LARGE),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).categoryLabel.toUpperCase(),
                          style: TextStyleFactory.overline(),
                        ),
                        SizedBox(height: PaddingSizeConfig.SMALL),
                        Text(
                          _model.getSelectedCategoryButtonTitle(context),
                          style: TextStyleFactory.subtitle2(),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: ColorConfig.FONT_PRIMARY),
                    onPressed: () {
                      _navigateToCategoryPicker(context);
                    },
                  ),
                ],
              ),
            ),
            DividerFactory.leftCutDivider(),
            Container(
              padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.info,
                      color: ColorConfig.FONT_PRIMARY,
                    ),
                    SizedBox(width: PaddingSizeConfig.LARGE),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).informationLabel.toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
                          _nameForm,
                          _descriptionForm,
                          _brandForm,
                          _sizeForm
                        ],
                      ),
                    ),
                  ]),
            ),
            DividerFactory.leftCutDivider(),
            Container(
              padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.color_lens,
                      color: ColorConfig.FONT_PRIMARY,
                    ),
                    SizedBox(width: PaddingSizeConfig.LARGE),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).mainColorLabel.toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
//                          Container(
//                            height: 40.0,
//                            child: ListView(
//                                scrollDirection: Axis.horizontal,
//                                children: _mainColorBoxes),
//                          )
                        ],
                      ),
                    ),
                  ]),
            ),
            DividerFactory.leftCutDivider(),
            _visibilityAndTradeSection,
            DividerFactory.leftCutDivider(),
            Container(
              padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.photo_library,
                      color: ColorConfig.FONT_PRIMARY,
                    ),
                    SizedBox(width: PaddingSizeConfig.LARGE),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).photosLabel.toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.LARGE),
                          Container(
                            height: PicturesListView.PHOTO_HEIGHT,
                            child: _picturesListView,
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
                    child: BeveledRectangleProgressButton(_saveButtonState,
                        title: S.of(context).saveAction),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _navigateToCategoryPicker(BuildContext context) async {
    ItemCategory category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
    if (category != null) {
      setState(() {
        _model.category = category;
      });
    }
  }

  _saveItem(BuildContext context) {
    if (_model.category == null) {
      final snackBar = SnackBar(
          content: Text(S.of(context).categoryRequiredErrorMessage),
          duration: Duration(seconds: 3));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      _saveButtonState.progress = true;
      String categoryItemsPath =
          'categories/${_model.category.toString()}/items';

      Firestore firestore = Firestore.instance;

      firestore
          .collection(categoryItemsPath)
          .document()
          .setData(_model.item.toMap())
          .whenComplete(() {
        firestore
            .collection(categoryItemsPath)
            .where('description', isEqualTo: _model.item.description)
            .where('brand', isEqualTo: _model.item.brand)
            .where('dateCreated', isEqualTo: _model.item.dateCreated)
            .snapshots()
            .first
            .then((querySnapshot) {
          return querySnapshot.documents.first;
        }).then((documentSnapshot) {
          final Item item = Item.fromSnapshot(documentSnapshot);
          print(item.toString());
          _saveButtonState.progress = false;
          Navigator.pop(context, item);
        }).catchError((error) {
          _saveButtonState.progress = false;
          print(error);
        });
      });
    }
  }

//  _onColorSelectionChanged(MainColorBox mainColorBox) {
//    if (mainColorBox.state.selected) {
//      _model.item.mainColor = mainColorBox.state.mainColor;
//      _mainColorBoxes.forEach((colorBox) {
//        if (colorBox != mainColorBox) colorBox.state.selected = false;
//      });
//    } else {
//      _model.item.mainColor = null;
//    }
//  }

  void _addImageFromGallery() {
    final uid = Uuid().v1();
    ImagePicker.pickImage(
            source: ImageSource.gallery, maxWidth: 1200.0, maxHeight: 1200.0)
        .then((imageFile) {
      if (imageFile != null) {
        _picturesListView.state.notifyUploadStarted();
//        print('IMAGE: $imageFile');
        final StorageReference ref =
            FirebaseStorage.instance.ref().child('pictures').child('$uid.jpg');
        ref
            .putFile(imageFile, StorageMetadata(contentType: 'image/jpeg'))
            .onComplete
            .then((uploadTaskSnapshot) {
          return uploadTaskSnapshot.ref.getDownloadURL();
        }).then((downloadUrl) {
          _model.item.addPicture(ItemPicture(uid, downloadUrl));
          return _model.item.pictures;
        }).then((pictures) {
          _picturesListView.state.pictures = pictures;
        });
      }
    });
  }

  Widget get _visibilityAndTradeSection => Container(
        padding: EdgeInsets.all(PaddingSizeConfig.LARGE),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                color: ColorConfig.FONT_PRIMARY,
              ),
              SizedBox(width: PaddingSizeConfig.LARGE),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).visibilityAndTradeLabel.toUpperCase(),
                      style: TextStyleFactory.overline(),
                    ),
                    SizedBox(height: PaddingSizeConfig.SMALL),
                    CheckboxListTile(
                        title: Text(S.of(context).privateCollectionLabel),
                        value: _model.privateCollection,
                        onChanged: (bool value) {
                          setState(() {
                            _model.privateCollection = value;
                          });
                        }),
                    CheckboxListTile(
                        title: Text(S.of(context).forSaleLabel),
                        value: _model.forSale,
                        onChanged: (bool value) {
                          setState(() {
                            _model.forSale = value;
                          });
                        }),
                    _priceInputSection
                  ],
                ),
              ),
            ]),
      );

  Widget get _priceInputSection => _model.forSale
      ? Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
          child: Row(
            children: <Widget>[
              Text(
                'Cena',
                style: TextStyleFactory.body1(),
              ),
              Container(
                width: PaddingSizeConfig.MEDIUM,
              ),
              Container(
                width: 100.0,
                child: PriceForm(
                    PriceFormState(_model.item.price, onPriceChanged: (price) {
                  _model.item.price = price;
                })),
              )
            ],
          ),
        )
      : Container();
}
