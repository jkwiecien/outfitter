import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outfitter/core/application.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/auth/auth_page.dart';
import 'package:outfitter/pages/discover/discover_page.dart';
import 'package:outfitter/pages/itemeditor/item_wizard.dart';
import 'package:outfitter/pages/wardrobe/wardrobe_page.dart';
import 'package:outfitter/utils/utils.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: ColorConfig.THEME_PRIMARY_DARK,
            onPressed: () {
              _onCreateClicked(context);
            }),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                  text: S.of(context).discoverTabTitle,
                  icon: Icon(
                    Icons.search,
                    color: ColorConfig.FONT_PRIMARY,
                  )),
              Tab(
                  text: S.of(context).myItemsTanTitle,
                  icon: Icon(MdiIcons.accountBoxOutline,
                      color: ColorConfig.FONT_PRIMARY)),
            ],
          ),
          title: Text(S.of(context).appNameLabel),
        ),
        body: TabBarView(
          children: [
            DiscoverPage(),
            WardrobePage(),
          ],
        ),
      ),
    );
  }

  void _onCreateClicked(BuildContext context) async {
    if (application.isLoggedIn()) {
      _navigateToItemCreator(context);
    } else {
      final user = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
      if (user != null) _navigateToItemCreator(context);
    }
  }

  void _navigateToItemCreator(BuildContext context) async {
    Item item = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ItemWizardPage(ItemWizardPageState(Item.newInstance()))));
    if (item != null) {
      setState(() {
        //TODO
      });
    }
  }
}
