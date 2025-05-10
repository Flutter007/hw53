import 'package:flutter/material.dart';
import 'package:hw53/screens/tasks_screen.dart';
import 'package:hw53/theme/light_theme.dart';

class Hw53 extends StatelessWidget {
  const Hw53({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: lightTheme, home: TasksScreen());
  }
}
