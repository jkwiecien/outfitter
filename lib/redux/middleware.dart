import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:outfitter/models/app_state.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/models/main_color.dart';
import 'package:outfitter/pages/filters/filters.dart';
import 'package:outfitter/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_DISCOVER_FILTERS = "discover_filters";

void discoverListMiddleware(
    Store<AppState> store, action, NextDispatcher next) {
  next(action);

  if (action is FetchDiscoverListAction) {
    loadFiltersFromCache().then((filters) {
      debugPrint("Loaded filters: $filters");
      store.dispatch(FiltersLoadedAction(filters));
      return loadDiscoverList(filters);
    }).then((items) {
      debugPrint("Loaded items: ${items.length}");
      store.dispatch(DiscoverListLoadedAction(items));
    });
  } else if (action is FiltersChangedAction) {
    saveFiltersToCache(store.state);
  }
}

void saveFiltersToCache(AppState state) async {
  debugPrint("Saving filters to cache: ${state.discoverFilters}");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var filtersJson = json.encode(state.discoverFilters.toJson());
  await preferences.setString(KEY_DISCOVER_FILTERS, filtersJson);
}

Future<Filters> loadFiltersFromCache() async {
  debugPrint("Loading filters from cache");
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var filtersJson = preferences.getString(KEY_DISCOVER_FILTERS);
    Map jsonMap = json.decode(filtersJson);
    var filters = Filters.fromJson(jsonMap);
    return filters;
  } on NoSuchMethodError {
    return Filters.createDefault();
  }
}

Future<List<Item>> loadDiscoverList(Filters filters) async {
  debugPrint("Loading discover list");

  final MainColor colorFilter = filters.color;

  Query query = Firestore.instance
      .collection('categories/${filters.category.toString()}/items');

  if (filters.forSaleOnly) {
    query = query.where('status', isEqualTo: Status.FOR_SALE);
  } else {
    query = query.where('status', isGreaterThanOrEqualTo: Status.PUBLIC);
  }

  if (colorFilter != MainColor.fromId(MainColorId.none))
    query = query.where('mainColor', isEqualTo: colorFilter.toString());

  return query.snapshots().first.then((snapshots) {
    return snapshots.documents
        .map((snapshot) => Item.fromSnapshot(snapshot))
        .toList();
  });
}
