import 'package:flutter/material.dart';

import 'package:hw53/widgets/task_form/task_form_controller.dart';

class TaskForm extends StatefulWidget {
  final void Function() onSave;
  final Widget widget;
  final TaskFormController controller;
  const TaskForm({
    super.key,
    required this.controller,
    required this.onSave,
    required this.widget,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: widget.controller.formKey,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: bottomInset + 20,
          ),
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
                ElevatedButton(
                  onPressed: widget.onSave,
                  child: Text('Save Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
