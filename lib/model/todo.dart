class Todo {
  int id;
  String task;
  bool completed;

  Todo({required this.id, required this.task, this.completed = false});

  static List<Todo> listTodo() {
    return [
      Todo(id: 1, task: 'Code', completed: true),
      Todo(id: 2, task: 'Exercise', completed: true),
      Todo(
        id: 3,
        task: 'Do dishes',
      ),
      Todo(
        id: 4,
        task: 'Chat',
      ),
      Todo(id: 5, task: 'Study', completed: true),
    ];
  }
}
