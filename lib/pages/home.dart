import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';
import '../translations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Outfitter')),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('categories').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Text(Translations.of(context).text('shoes'));
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: Text(Category
                      .fromString(document.documentID)
                      .getLocalisedName(context)),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
