import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/itemeditor/brand_form.dart';
import 'package:outfitter/pages/itemeditor/description_form.dart';
import 'package:outfitter/pages/itemeditor/model.dart';
import 'package:outfitter/pages/itemeditor/name_form.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/beveled_rectangle_button.dart';
import 'package:outfitter/widgets/widgets.dart';

class ItemWizardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemWizardPageState();
}

class _ItemWizardPageState extends State<ItemWizardPage> {
  final ItemEditorModel _model = ItemEditorModel();

  ItemNameForm _nameForm;
  ItemDescriptionForm _descriptionForm;
  ItemBrandForm _brandForm;

  @override
  void initState() {
    _nameForm = ItemNameForm(onTextChanged: (text) {
      _model.item.name = text;
    });
    _descriptionForm = ItemDescriptionForm(onTextChanged: (text) {
      _model.item.description = text;
    });
    _brandForm = ItemBrandForm(onTextChanged: (text) {
      _model.item.brand = text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.BACKGROUND,
      appBar: AppBarFactory.flatAppBar(context,
          navigationIcon: Icons.close,
          title: _model.isEdit()
              ? Translations.forKey('page_title_creator_edit', context)
              : Translations.forKey('page_title_creator_create', context)),
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
                          Translations
                              .forKey('label_category', context)
                              .toUpperCase(),
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
                            Translations
                                .forKey('label_information', context)
                                .toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
                          _nameForm,
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
                            Translations
                                .forKey('label_main_color', context)
                                .toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
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
                            Translations
                                .forKey('label_photos', context)
                                .toUpperCase(),
                            style: TextStyleFactory.overline(),
                          ),
                          SizedBox(height: PaddingSizeConfig.SMALL),
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
                    child: BeveledRectangleButton(
                      title: Translations.forKey('action_save', context),
                      icon: Icons.save,
                      onPressed: () {
                        _saveItem();
                      },
                    ),
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
    Category category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
    setState(() {
      _model.category = category;
    });
  }

  _saveItem() {
    if (_nameForm.validate()) {
      try {
        Firestore.instance
            .collection('categories/${_model.category.toString()}/items')
            .document()
            .setData(_model.item.toMap());
      } catch (error) {
        print(error.toString());
      }
    }
  }
}
