

//class CategoriesList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('categories').snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (!snapshot.hasData) return new Text('Loading...');
//        return new ListView(
//          children: snapshot.data.documents.map((DocumentSnapshot document) {
//            return new ListTile(
//              title: new Text(Category
//                  .fromString(document.documentID)
//                  .getLocalisedName(context)),
//            );
//          }).toList(),
//        );
//      },
//    );
//  }
//}
