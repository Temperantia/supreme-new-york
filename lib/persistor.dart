import 'dart:convert';

import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:supreme/store/app_state.dart';

class AppPersistor extends Persistor {
  final persist = LocalPersist("proxies");

  @override
  Future<void> deleteState() {
    throw UnimplementedError();
  }

  @override
  Future<void> persistDifference({lastPersistedState, newState}) async {
    await persist.save(newState.proxies);
  }

  @override
  Future readState() async {
    List<Object> proxies = await persist.load();
    if (proxies != null) {
      proxies = proxies.cast<String>();
    }

    return AppState.initialState(proxies: proxies);
  }
}
