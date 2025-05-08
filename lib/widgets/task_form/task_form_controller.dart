import 'package:flutter/cupertino.dart';

import '../../models/task.dart';

class TaskFormController {
  final formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();

  void setTask(Task task) {
    taskController.text = task.task;
  }

  void dispose() {
    taskController.dispose();
  }
}
