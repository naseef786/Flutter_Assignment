class Todo {
  int? id;
  String title;
  String description;

  Todo({this.id, required this.title, required this.description});

  // Convert Todo to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  // Convert Map to Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
