import 'package:flutter/material.dart';
import 'package:hw53/models/task_category.dart';

final categories = [
  TaskCategory(id: 'work', label: 'Work', icon: Icons.attach_money_outlined),
  TaskCategory(id: 'study', label: 'Study', icon: Icons.school_outlined),
  TaskCategory(
    id: 'meeting',
    label: 'Meeting',
    icon: Icons.emoji_people_outlined,
  ),
  TaskCategory(id: 'urgent', label: 'Urgent', icon: Icons.error_outline),
  TaskCategory(
    id: 'training',
    label: 'Training',
    icon: Icons.sports_gymnastics_outlined,
  ),
];
