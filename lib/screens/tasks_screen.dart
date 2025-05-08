import 'package:flutter/material.dart';
import 'package:hw53/helpers/request.dart';
import 'package:hw53/models/task.dart';

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
  String? selectedCategory;
  late List<Task> tasks;

  void fetchTasks() async {
    try {
      final url =
          'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/tasks.json';
      final Map<String, dynamic> response = await request(url);
      setState(() {
        tasks =
            response.values.map<Task>((task) => Task.fromJson(task)).toList();
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void onSave() async {
    if (controller.formKey.currentState!.validate()) {
      try {
        final task = Task(
          task: controller.taskController.text,
          categoryId: selectedCategory!,
          createdAt: DateTime.now(),
        );
        final url =
            'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/tasks.json';
        await request(url, method: 'POST', body: task.toJson());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order created successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error creating order: $e')));
        }
      }
    }
  }

  void openTaskForm() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder:
          (ctx) => TaskForm(
            onSave: onSave,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remember to do:'),
        actions: [IconButton(onPressed: openTaskForm, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder:
                    (ctx, i) => ListTile(
                      title: Text(tasks[i].task),
                      subtitle: Text(tasks[i].categoryId),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
