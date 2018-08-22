import 'package:flutter/material.dart';
import 'package:outfitter/configuration.dart';

import '../translations.dart';

class ItemCreatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title:
              Text(Translations.of(context).text('page_title_creator_create'))),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.category),
                Column(
                  children: <Widget>[
                    Text(
                      Translations
                          .of(context)
                          .text('hint_category_input')
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: FontSizeConfig.LARGE,
                          fontWeight: FontWeightConfig.MEDIUM,
                          fontStyle: FontStyleConfig.ITALIC),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
