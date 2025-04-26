import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/blocs/todo/todo_bloc.dart';
import 'package:to_do/blocs/todo/todo_events.dart';
import 'package:to_do/models/task_model.dart';

class AddTaskPopup extends StatefulWidget {
  const AddTaskPopup({super.key});

  @override
  State<AddTaskPopup> createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      final task = Task(title: title, isCompleted: false);
      context.read<TodoBloc>().add(AddTask(task));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter task title'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
