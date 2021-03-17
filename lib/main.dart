import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:supreme/persistor.dart';
import 'package:supreme/routes.dart';
import 'package:supreme/store/app_state.dart';
import 'package:supreme/theme.dart';
import 'package:supreme/view/login_view.dart';
import 'package:supreme/view/main_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Store store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final persistor = AppPersistor();
  var initialState = await persistor.readState();
  if (initialState == null) {
    initialState = AppState.initialState();
    await persistor.saveInitialState(initialState);
  }
  store = Store<AppState>(initialState: initialState, persistor: persistor);

  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AsyncReduxProvider<AppState>.value(
      value: store,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: MainView(),
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => routes[settings.name](settings.arguments)),
      ),
    );
  }
}
