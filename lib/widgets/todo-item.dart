import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final changeTodoStatus;
  final deleteTodo;

  const TodoItem({
    super.key,
    required this.todo,
    required this.changeTodoStatus,
    required this.deleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        onTap: () {
          changeTodoStatus(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
          color: myBlue,
        ),
        title: Text(
          todo.task,
          style: TextStyle(
            fontSize: 16,
            color: myBlack,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: myRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            icon: const Icon(Icons.delete_forever),
            color: Colors.white,
            iconSize: 18,
            onPressed: () {
              deleteTodo(todo);
            },
          ),
        ),
      ),
    );
  }
}
