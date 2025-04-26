import '../../models/task_model.dart';

abstract class TodoEvent {}

class LoadTasks extends TodoEvent {}

class AddTask extends TodoEvent {
  final Task task;
  AddTask(this.task);
}

class UpdateTask extends TodoEvent {
  final Task task;
  UpdateTask(this.task);
}

class DeleteTask extends TodoEvent {
  final Task task;
  DeleteTask(this.task);
}

enum FilterType { all, completed, pending }

class FilterTasks extends TodoEvent {
  final FilterType filter;
  FilterTasks(this.filter);
}
