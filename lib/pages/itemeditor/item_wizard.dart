import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/l10n/translations.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/models/picture.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/itemeditor/brand_form.dart';
import 'package:outfitter/pages/itemeditor/description_form.dart';
import 'package:outfitter/pages/itemeditor/model.dart';
import 'package:outfitter/pages/itemeditor/pictures_list.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';
import 'package:outfitter/widgets/main_color_box.dart';
import 'package:outfitter/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class ItemWizardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemWizardPageState();
}

class _ItemWizardPageState extends State<ItemWizardPage> {
  final ItemEditorModel _model = ItemEditorModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ItemDescriptionForm _descriptionForm;
  ItemBrandForm _brandForm;
  List<MainColorBox> _mainColorBoxes;
  PicturesListView _picturesListView;
  BeveledRectangleProgressButtonState _saveButtonState;

  @override
  void initState() {
    _descriptionForm = ItemDescriptionForm(onTextChanged: (text) {
      _model.item.description = text;
    });
    _brandForm = ItemBrandForm(onTextChanged: (text) {
      _model.item.brand = text;
    });

    _mainColorBoxes = [
      MainColorBox(MainColor(MainColorId.white), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.grey), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.black), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.red), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.pink), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.purple), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.blue), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.green), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.yellow), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.orange), _onColorSelectionChanged),
      MainColorBox(MainColor(MainColorId.brown), _onColorSelectionChanged)
    ];

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
          title: _model.isEdit()
              ? Translations.of(context).editItemPageTitle
              : Translations.of(context).createItemPageTitle),
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
                          Translations.of(context).categoryLabel.toUpperCase(),
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
                            Translations.of(context)
                                .informationLabel
                                .toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
                          _descriptionForm,
                          _brandForm
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
                            Translations.of(context)
                                .mainColorLabel
                                .toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
                          Container(
                            height: 40.0,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: _mainColorBoxes),
                          )
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
                      Icons.photo_library,
                      color: ColorConfig.FONT_PRIMARY,
                    ),
                    SizedBox(width: PaddingSizeConfig.LARGE),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translations.of(context).photosLabel.toUpperCase(),
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
                        title: Translations.of(context).saveAction),
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
          content: Text(Translations.of(context).categoryRequiredErrorMessage),
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

  _onColorSelectionChanged(MainColorBox mainColorBox) {
    if (mainColorBox.state.selected) {
      _model.item.mainColor = mainColorBox.mainColor;
      _mainColorBoxes.forEach((colorBox) {
        if (colorBox != mainColorBox) colorBox.state.selected = false;
      });
    } else {
      _model.item.mainColor = null;
    }
  }

  void _addImageFromGallery() {
//    final url = 'https://firebasestorage.googleapis.com/v0/b/pocket-outfitter.appspot.com/o/pictures%2F0284e33d-f03b-463d-8bd1-b5ad3db401d0.jpg?alt=media&token=0aabd1f6-cc44-4013-be5d-fb27190dc9e2';
//    _model.item.pictures.add(url);
//    _picturesListView.state.urls = _model.item.pictures;
    final uid = Uuid().v4();
    ImagePicker.pickImage(
            source: ImageSource.gallery, maxWidth: 1200.0, maxHeight: 1200.0)
        .then((imageFile) {
      if (imageFile != null) {
        _picturesListView.state.notifyUploadStarted();
        print('IMAGE: $imageFile');
        application.firebaseStorage().then((storage) {
          final StorageReference ref =
              storage.ref().child('pictures').child('$uid.jpg');
          final StorageUploadTask uploadTask = ref.putFile(
              imageFile, StorageMetadata(contentType: 'image/jpeg'));
          return uploadTask.future;
        }).then((uploadTaskSnapshot) {
          final Uri downloadUrl = uploadTaskSnapshot.downloadUrl;
          final url = downloadUrl.toString();
          _model.item.addPicture(ItemPicture(uid, url));
          return _model.item.pictures;
        }).then((pictures) {
          _picturesListView.state.pictures = pictures;
        });
      }
    });
  }
}
