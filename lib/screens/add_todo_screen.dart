import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/database_helper.dart';

class AddTodoScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  AddTodoScreen({super.key});

  void _addTodo(BuildContext context) async {
    if (_titleController.text.isEmpty || _descController.text.isEmpty) return;

    final newTodo = Todo(title: _titleController.text, description: _descController.text);
    await DatabaseHelper.instance.addTodo(newTodo);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _descController, decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _addTodo(context), child: Text('Add Todo'))
          ],
        ),
      ),
    );
  }
}
