import 'package:async_redux/async_redux.dart';
import 'package:supreme/model/profile.dart';
import 'package:supreme/store/app_state.dart';

class ProfileCreateAction extends ReduxAction<AppState> {
  ProfileCreateAction(this.profile);

  final Profile profile;

  @override
  AppState reduce() {
    return state.copy(profiles: state.profiles..add(profile));
  }
}
