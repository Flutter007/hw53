import 'package:flutter/material.dart';
import 'package:hw53/widgets/task_form/task_form_controller.dart';

class TaskForm extends StatefulWidget {
  final Widget widget;
  final void Function()? onPressed;

  final TaskFormController controller;

  const TaskForm({
    super.key,
    required this.controller,
    required this.widget,
    required this.onPressed,
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
          padding: EdgeInsets.only(left: 60, right: 60, bottom: bottomInset),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.onPressed,
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
