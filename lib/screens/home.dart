import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/todo-item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.listTodo();
  List<Todo> _filteredTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _filteredTodo = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: myBg,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                          bottom: 20,
                        ),
                        child: const Text(
                          'Your Goals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (_filteredTodo.isEmpty)
                        const Center(
                            child: Text(
                          'No goals set',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ))
                      else
                        for (Todo todo in _filteredTodo.reversed)
                          TodoItem(
                            todo: todo,
                            changeTodoStatus: _handleTodoChange,
                            deleteTodo: _handleTodoDelete,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                      ),
                    ]),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add new goal',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDo(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        60,
                        60,
                      ),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _handleTodoDelete(Todo todo) {
    setState(() {
      todoList.removeWhere((element) => element.id == todo.id);
    });
  }

  void _addToDo(String task) {
    setState(() {
      todoList.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          task: task,
        ),
      );
      _todoController.clear();
    });
  }

  void _filterTodo(String query) {
    List<Todo> result = [];
    if (query.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((element) =>
              element.task.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredTodo = result;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: myBg,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: myBlack,
            size: 30,
          ),
          Icon(
            Icons.person,
            color: myBlack,
            size: 30,
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _filterTodo(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: myBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Filter todo',
          hintStyle: TextStyle(color: myGray),
        ),
      ),
    );
  }
}
