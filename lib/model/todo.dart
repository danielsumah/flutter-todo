class Todo {
  String id;
  String task;
  bool completed;

  Todo({required this.id, required this.task, this.completed = false});

  static List<Todo> listTodo() {
    return [];
  }
}
