import 'package:async_redux/async_redux.dart';
import 'package:supreme/store/app_state.dart';

class ProxySwitchAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copy(proxyEnabled: !state.proxyEnabled);
  }
}
