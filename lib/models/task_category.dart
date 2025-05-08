import 'package:flutter/material.dart';

class TaskCategory {
  final String id;
  final String label;
  final IconData icon;

  TaskCategory({required this.id, required this.label, required this.icon});

  Map<String, dynamic> toJson() {
    return {'id': id, 'label': label, 'icon': icon};
  }
}
