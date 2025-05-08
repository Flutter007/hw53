import 'package:flutter/material.dart';

import '../models/task.dart';
import 'custom_text.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final void Function() deleteTask;
  const TaskCard({super.key, required this.task, required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: CustomText(txt: task.task),
          subtitle: CustomText(txt: task.categoryId),
          trailing: IconButton(onPressed: deleteTask, icon: Icon(Icons.delete)),
        ),
      ),
    );
  }
}
