import 'package:flutter/material.dart';
import 'package:outfitter/utils.dart';
import 'package:outfitter/widgets.dart';

import '../translations.dart';

class ItemCreatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.THEME_SECONDARY,
      appBar: AppBarFactory.flatAppBar(context,
          navigationIcon: Icons.close,
          title: Translations.forKey('page_title_creator_create', context),
          backgroundColor: ColorConfig.THEME_PRIMARY),
      body: Container(
        padding: EdgeInsets.fromLTRB(PaddingSizeConfig.LARGE, 0.0, 0.0, 0.0),
        child: Column(
          children: <Widget>[
            DividerFactory.leftCutDivider(offset: 40.0),
            Container(
              padding:
                  EdgeInsets.fromLTRB(0.0, 0.0, PaddingSizeConfig.SMALL, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.category, color: ColorConfig.FONT_PRIMARY),
                  SizedBox(width: PaddingSizeConfig.LARGE),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translations
                              .forKey('hint_category_input', context)
                              .toUpperCase(),
                          style: TextStyle(fontSize: FontSizeConfig.MEDIUM),
                        ),
                        SizedBox(height: PaddingSizeConfig.SMALL),
                        Text(Translations.forKey('shoes', context),
                            style:
                                TextStyle(fontWeight: FontWeightConfig.MEDIUM))
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: ColorConfig.FONT_PRIMARY,
                    ),
                    onPressed: () {
                      //TODO
                    },
                  ),
                ],
              ),
            ),
            DividerFactory.leftCutDivider(offset: 40.0),
          ],
        ),
      ),
    );
  }
}
