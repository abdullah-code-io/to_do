import 'package:to_do/blocs/todo/todo_events.dart';

import '../../models/task_model.dart';

abstract class TodoState {}

class TaskLoading extends TodoState {}

class TaskLoaded extends TodoState {
  final List<Task> tasks;
  final List<Task> filteredTasks;
  final FilterType filter;

  TaskLoaded({
    required this.tasks,
    List<Task>? filteredTasks,
    this.filter = FilterType.all,
  }) : filteredTasks = filteredTasks ?? tasks;
}
