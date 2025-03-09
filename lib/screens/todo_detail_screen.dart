import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;
  const TodoDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
