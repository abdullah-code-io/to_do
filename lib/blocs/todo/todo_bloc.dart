import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/blocs/todo/to_do_states.dart';
import 'package:to_do/blocs/todo/todo_events.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/services/database_service.dart';


class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Task> _allTasks = [];

  TodoBloc() : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<FilterTasks>(_onFilterTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TodoState> emit) async {
    print("Loading tasks...");
    emit(TaskLoading());
    _allTasks = await TaskDatabase.instance.getTasks();
    emit(TaskLoaded(tasks: _allTasks, filter: FilterType.all));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TodoState> emit) async {
    await TaskDatabase.instance.insertTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TodoState> emit) async {
    await TaskDatabase.instance.updateTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TodoState> emit) async {
    await TaskDatabase.instance.deleteTask(event.task.id!);
    add(LoadTasks());
  }

  void _onFilterTasks(FilterTasks event, Emitter<TodoState> emit) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      List<Task> filtered;
      switch (event.filter) {
        case FilterType.completed:
          filtered = _allTasks.where((t) => t.isCompleted).toList();
          break;
        case FilterType.pending:
          filtered = _allTasks.where((t) => !t.isCompleted).toList();
          break;
        default:
          filtered = _allTasks;
      }
      emit(TaskLoaded(tasks: _allTasks, filteredTasks: filtered, filter: event.filter));
    }else{
      print("State is not TaskLoaded");
    }
  }
}

