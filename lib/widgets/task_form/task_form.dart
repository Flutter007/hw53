import 'package:flutter/material.dart';

import 'package:hw53/widgets/task_form/task_form_controller.dart';

class TaskForm extends StatefulWidget {
  final Widget widget;
  final TaskFormController controller;

  const TaskForm({super.key, required this.controller, required this.widget});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  String? selectedCategory;
  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: widget.controller.formKey,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 60, right: 60, bottom: bottomInset),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Task'),
                  controller: widget.controller.taskController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                widget.widget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
