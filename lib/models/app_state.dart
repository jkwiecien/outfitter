import 'package:meta/meta.dart';
import 'package:outfitter/models/item.dart';
import 'package:outfitter/pages/filters/filters.dart';

@immutable
class AppState {
  static var empty = AppState(Filters.createDefault(), List());

  final Filters discoverFilters;
  final List<Item> discoverItems;

  AppState(this.discoverFilters, this.discoverItems);
}
