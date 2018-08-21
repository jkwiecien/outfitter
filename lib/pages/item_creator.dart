import 'package:flutter/material.dart';

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
            TextField(),
          ],
        ),
      ),
    );
  }
}
