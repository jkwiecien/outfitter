import 'package:flutter/material.dart';
import 'package:outfitter/model/category.dart';
import 'package:outfitter/pages/category_picker.dart';
import 'package:outfitter/pages/itemeditor/model.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils.dart';

class ItemEditorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemEditorPageState();
}

class _ItemEditorPageState extends State<ItemEditorPage> {
  final ItemEditorModel _model =
      ItemEditorModel(Category.fromId(CategoryId.shoes));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              Translations.forKey('page_title_creator_create', context),
              style: TextStyle(color: ColorConfig.FONT_PRIMARY),
            ),
            leading: IconButton(
                icon: Icon(Icons.close, color: ColorConfig.FONT_PRIMARY),
                onPressed: () {
                  Navigator.pop(context);
                }),
            expandedHeight: 240.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: 220.0,
                child: Image.network(
                    'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(PaddingSizeConfig.MEDIUM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.category,
                        color: ColorConfig.FONT_PRIMARY,
                        size: 20.0,
                      ),
                      MaterialButton(
                        child: Text(
                          _model
                              .getSelectedCategoryButtonTitle(context)
                              .toUpperCase(),
                          style: TextStyleFactory.button(),
                        ),
                        onPressed: () {
                          _navigateToCategoryPicker(context);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: PaddingSizeConfig.MEDIUM,
                  ),
                  TextField(
                    style: TextStyleFactory.h5(),
                    decoration: InputDecoration(
                        hintText:
                            Translations.forKey('hint_name_input', context),
                        hintStyle:
                            TextStyleFactory.h5(color: ColorConfig.FONT_HINT)),
                  ),
                  SizedBox(
                    height: PaddingSizeConfig.LARGE,
                  ),
                  TextField(
                    style: TextStyleFactory.body2(),
                    decoration: InputDecoration(
                        hintText: 'Producent',
                        hintStyle: TextStyleFactory.body2(
                            color: ColorConfig.FONT_HINT)),
                  ),
                  TextField(
                    style: TextStyleFactory.body2(),
                    decoration: InputDecoration(
                        hintText: Translations.forKey(
                            'hint_description_input', context),
                        hintStyle: TextStyleFactory.body2(
                            color: ColorConfig.FONT_HINT)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _navigateToCategoryPicker(BuildContext context) async {
    Category category = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryPickerPage()));
//    print(category.getLocalisedName(context));

    setState(() {
      _model.selectedCategory = category;
    });
  }
}
