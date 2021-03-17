import 'package:supreme/model/profile.dart';
import 'package:supreme/model/task.dart';
import 'package:supreme/model/user.dart';

class AppState {
  AppState({
    this.user,
    this.profiles,
    this.tasks,
    this.proxyEnabled,
    this.proxies,
  });

  final User user;
  final List<Profile> profiles;
  final List<Task> tasks;
  final bool proxyEnabled;
  final List<String> proxies;

  AppState copy({
    User user,
    List<Profile> profiles,
    List<Task> tasks,
    bool proxyEnabled,
    List<String> proxies,
  }) =>
      AppState(
        user: user ?? this.user,
        profiles: profiles ?? this.profiles,
        tasks: tasks ?? this.tasks,
        proxyEnabled: proxyEnabled ?? this.proxyEnabled,
        proxies: proxies ?? this.proxies,
      );

  static AppState initialState({List<String> proxies}) {
    return AppState(
      user: User(),
      profiles: [],
      tasks: [],
      proxyEnabled: false,
      proxies: proxies,
    );
  }
}
