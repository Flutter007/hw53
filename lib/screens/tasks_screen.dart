import 'package:flutter/material.dart';
import 'package:hw53/helpers/request.dart';
import 'package:hw53/models/task.dart';
import 'package:hw53/widgets/task_card.dart';
import '../data/category_data.dart';
import '../widgets/task_form/task_form.dart';
import '../widgets/task_form/task_form_controller.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final controller = TaskFormController();
  String baseURL =
      'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/';
  String? selectedCategory;
  bool isFetching = false;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Task $message !')));
    }
  }

  void deleteTask(Task task) async {
    setState(() => isFetching = true);
    final url = '${baseURL}tasks/${task.id}.json';
    await request(url, method: 'DELETE');
    setState(() => isFetching = false);
    await fetchTasks();
    showMessage('deleted');
  }

  Future<bool?> showDeleteConfirmingDialog() async {
    return showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Remove Task'),
            content: Text('Are you sure to remove?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Confirm'),
              ),
            ],
          ),
    );
  }

  void confirmAndDeleteTask(Task task) async {
    final deleteForm = await showDeleteConfirmingDialog();
    if (deleteForm != true) {
      return;
    }
    deleteTask(task);
  }

  Future<void> fetchTasks() async {
    List<Task> newTasks = [];
    setState(() => isFetching = true);
    try {
      final url = '${baseURL}tasks.json';
      final Map<String, dynamic>? response = await request(url);

      if (response != null) {
        for (final key in response.keys) {
          final task = Task.fromJson({...response[key], 'id': key});
          newTasks.add(task);
        }
        setState(() {
          tasks = newTasks;
        });
      } else {
        setState(() {
          tasks = [];
        });
      }
    } catch (e) {
      showMessage('error');
    } finally {
      setState(() => isFetching = false);
    }
  }

  void onSave() async {
    if (controller.formKey.currentState!.validate() &&
        selectedCategory != null) {
      try {
        Navigator.of(context).pop();
        final task = Task(
          task: controller.taskController.text,
          categoryId: selectedCategory!,
          createdAt: DateTime.now(),
        );
        final url = '${baseURL}tasks.json';
        await request(url, method: 'POST', body: task.toJson());
        controller.taskController.clear();
        if (mounted) {
          setState(() => selectedCategory = null);
        }
        await fetchTasks();
        showMessage('saved');
      } catch (e) {
        showMessage('error');
      }
    }
  }

  void openTaskForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder:
          (ctx) => SingleChildScrollView(
            child: Column(
              children: [
                TaskForm(
                  onPressed: onSave,
                  controller: controller,
                  widget: DropdownMenu(
                    label: Text('Category :'),
                    expandedInsets: EdgeInsets.zero,
                    onSelected: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    dropdownMenuEntries:
                        categories
                            .map(
                              (category) => DropdownMenuEntry(
                                value: category.id,
                                label: category.label,
                                leadingIcon: Icon(category.icon),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget content;
    if (isFetching) {
      content = Center(child: CircularProgressIndicator());
    } else {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tasks.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder:
                        (ctx, i) => TaskCard(
                          task: tasks[i],
                          deleteTask: () => confirmAndDeleteTask(tasks[i]),
                        ),
                  ),
                )
                : Text('No tasks yet', style: theme.textTheme.titleLarge),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Remember to do:'),
        actions: [
          IconButton(onPressed: openTaskForm, icon: Icon(Icons.add, size: 30)),
        ],
      ),
      body: content,
    );
  }
}
