import 'package:flutter/material.dart';

class TodoListTile {
  bool isDone = false;
  String title;

  TodoListTile(this.title);
}

class TodoListProvider with ChangeNotifier {
  final _todoItems = <TodoListTile>[]; 
  final _todoPackCollection = [];
  
  // todoPackCollection.add(_todoItems);
  

  get todoItems => _todoItems;
  get todoPackCollection => _todoPackCollection;
  //todo는 title을 넘겨주며 생성자를 통환 초기화가 필요함.
  void addTodo(TodoListTile todo) { //TodoListTIle타입의 tod_todoPackCollection 내에는 isDone과 title이 있음.
      _todoItems.add(todo);
      notifyListeners();
  }

  void deleteTodo(TodoListTile todo) {
     _todoItems.remove(todo);
     notifyListeners();
  }

  void toggleTodo(TodoListTile todo) {
      todo.isDone = !todo.isDone;
      notifyListeners();
  }

  Widget buildItemWidget(TodoListTile todo) {
    return ListTile(
      onTap: () => toggleTodo(todo),
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontFamily: 'Dot',
                fontSize: 20
              )
            : TextStyle(
              color: Colors.lightGreen[600],
              fontFamily: 'Dot',
              fontSize: 20
              ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => deleteTodo(todo),
      ),
    );
  }
} 