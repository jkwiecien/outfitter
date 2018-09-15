
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/discover/discover_page.dart';
import 'package:outfitter/pages/itemeditor/item_wizard.dart';
import 'package:outfitter/utils/utils.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: ColorConfig.THEME_PRIMARY_DARK,
            onPressed: () {
              _navigateToItemCreator(context);
            }),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Icon(
                    MdiIcons.accountMultipleOutline,
                    color: ColorConfig.FONT_PRIMARY,
                  )),
              Tab(
                  icon: Icon(MdiIcons.accountBoxOutline,
                      color: ColorConfig.FONT_PRIMARY)),
            ],
          ),
          title: Text(S.of(context).appNameLabel),
        ),
        body: TabBarView(
          children: [
            DiscoverPage(),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }

  void _navigateToItemCreator(BuildContext context) async {
    Item item = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ItemWizardPage(ItemWizardPageState(Item.newInstance()))));
    if (item != null) {
      //TODO
    }
  }
}