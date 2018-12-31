import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/filters/filters.dart';

class FetchDiscoverListAction {}

class FiltersLoadedAction {
  final Filters filters;

  FiltersLoadedAction(this.filters);
}

class FiltersChangedAction {
  final Filters filters;

  FiltersChangedAction(this.filters);

  @override
  String toString() => "$runtimeType to: $filters";
}

class DiscoverListLoadedAction {
  final List<Item> items;

  DiscoverListLoadedAction(this.items);
}

class LikeItemAction {
  final Item item;

  LikeItemAction(this.item);
}

class UnLikeItemAction {
  final Item item;

  UnLikeItemAction(this.item);
}
