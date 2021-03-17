import 'package:async_redux/async_redux.dart';
import 'package:supreme/store/app_state.dart';

class ProxiesSaveAction extends ReduxAction<AppState> {
  ProxiesSaveAction(this.input);

  final String input;

  @override
  AppState reduce() {
    final List<String> proxies = input.split('\n');
    return state.copy(proxies: proxies);
  }
}
