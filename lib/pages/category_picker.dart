import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils/utils.dart';
import 'package:outfitter/widgets/widgets.dart';

typedef void OnCategoryPicked(ItemCategory category);

class CategoryPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.THEME_PRIMARY,
      appBar: AppBarFactory.flatAppBar(context,
          backgroundColor: ColorConfig.THEME_PRIMARY,
          title: Translations.of(context).text('page_title_pick_category'),
          navigationIcon: Icons.close),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('categories').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Text(
                Translations.of(context).text('label_loading'),
                style: TextStyleFactory.subtitle1(),
              );
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        final category =
                            ItemCategory.fromString(document.documentID);
                        Navigator.pop(context, category);
                      },
                      title: Text(
                        ItemCategory
                            .fromString(document.documentID)
                            .getLocalisedName(context)
                            .toUpperCase(),
                        style: TextStyleFactory.button(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                        child: SizedBox(width: 60.0, height: 2.0),
                        color: ColorConfig.DIVIDER)
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
