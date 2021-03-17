import 'package:async_redux/async_redux.dart';
import 'package:supreme/model/task.dart';
import 'package:supreme/store/app_state.dart';

class TaskCreateAction extends ReduxAction<AppState> {
  TaskCreateAction(this.task);

  final Task task;

  @override
  AppState reduce() {
    return state.copy(tasks: state.tasks..add(task));
  }
}
