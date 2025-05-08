import 'package:flutter/material.dart';
import 'package:hw53/screens/tasks_screen.dart';

class Hw53 extends StatefulWidget {
  const Hw53({super.key});

  @override
  State<Hw53> createState() => _Hw53State();
}

class _Hw53State extends State<Hw53> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TasksScreen());
  }
}
