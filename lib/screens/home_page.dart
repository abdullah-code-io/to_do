import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/blocs/todo/to_do_states.dart';
import 'package:to_do/blocs/todo/todo_bloc.dart';
import 'package:to_do/blocs/todo/todo_events.dart';
import 'package:to_do/screens/add_task_popup.dart';
import 'package:to_do/screens/confirmation_dialog.dart';
import 'package:to_do/screens/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('My To-Do'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'All':
                  context.read<TodoBloc>().add(FilterTasks(FilterType.all));
                  break;
                case 'Completed':
                  context
                      .read<TodoBloc>()
                      .add(FilterTasks(FilterType.completed));
                  break;
                case 'Pending':
                  context.read<TodoBloc>().add(FilterTasks(FilterType.pending));
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
            ],
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.filteredTasks;
            if (tasks.isEmpty) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel, size: 50, color: Colors.grey),
                  SizedBox(height: 20),
                  Text("No tasks found."),
                ],
              ));
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).cardColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: Colors.green,
                        value: task.isCompleted,
                        onChanged: (_) {
                          context.read<TodoBloc>().add(UpdateTask(
                              task.copyWith(isCompleted: !task.isCompleted)));
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          confirmationDialog(
                              context,
                              'Delete task',
                              'Are you sure you want to delete this task',
                              'Yes', () {
                            context.read<TodoBloc>().add(DeleteTask(task));
                            Navigator.of(context).pop();
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddTaskPopup(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
