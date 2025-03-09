import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/database_helper.dart';
import 'add_todo_screen.dart';
import 'todo_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await DatabaseHelper.instance.getTodos();
    setState(() => _todos = todos);
  }

  void _deleteTodo(int id) async {
    await DatabaseHelper.instance.deleteTodo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: _todos.isEmpty
          ? Center(child: Text('No Todos Found'))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TodoDetailScreen(todo: todo)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTodo(todo.id!),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => AddTodoScreen()));
          _loadTodos();
        },
      ),
    );
  }
}
