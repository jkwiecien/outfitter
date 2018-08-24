import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/models/category.dart';
import 'package:outfitter/pages/itemeditor/item_editor.dart';
import 'package:outfitter/translations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(Translations.of(context).text('label_app_name'))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemEditorPage()),
          );
        },
      ),
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
