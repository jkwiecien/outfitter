import 'package:outfitter/models/app_state.dart';
import 'package:outfitter/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  print("Reducer action: $action");
  if (action is FiltersLoadedAction) {
    return AppState(action.filters, state.discoverItems);
  } else if (action is FiltersChangedAction) {
    return AppState(action.filters, state.discoverItems);
  } else if (action is DiscoverListLoadedAction) {
    return AppState(state.discoverFilters, action.items);
  } else {
    return state;
  }
}
