import 'package:flutter/material.dart';
import 'package:planbreaker/widget/MoveableStackItem.dart';
import 'package:planbreaker/widget/Todolist.dart';

class MoveableProvider with ChangeNotifier {
  Map _moveableMap = {};
  final List<Widget> _movableItems = [];  //MoveableStackItem타입을 담고 있는 리스트
  final List<String> _moveableNames = [];
  final List<Widget> _todoList = [];
  int removeIndex = 0;

  // int _top = -1;
  int _inputCounter = 0;

  get inputCounter => _inputCounter;
  // get top => _top;

  get movableItems => _movableItems;
  get moveableNames => _moveableNames;
  get moveableMap => _moveableMap;
  get todoList => _todoList;

  void decrementInputCounter() {
    _inputCounter--;
  }

  //   void topCounter() {
  //   _top--;
  // }

  void addName(String moveableame, TextEditingController controller) {
      moveableNames.add(moveableame);
      controller.text = "";
      // _top++;
      print('moveable addName : ');
      print(_moveableNames);
      moveableAdd();
      notifyListeners();
  }

  void moveableAdd() {
    _movableItems.add(MoveableStackItem(moveableStackItemCount: _inputCounter, moveableName: moveableNames[_inputCounter]));
    todoListAdd();

    print('moveable lengthItems : ' + '$_movableItems');
    moveWeave();
    notifyListeners();
  }

  void moveWeave() {
    _moveableMap[_moveableNames[_inputCounter]] = _movableItems[_inputCounter];
    print(_moveableMap[_moveableNames[_inputCounter]]);
    print('moveableMap :  ' + '${_moveableMap.length}');
    _inputCounter++;
    notifyListeners();
  }

  void todoListAdd() {
    _todoList.add(TodoListView(todoName: moveableNames[_inputCounter]));
    print('todolist length: ' + '${todoList.length}');
  }

  void todoListRemove() {
    _todoList.removeAt(removeIndex);
    removeIndex = 0;
  }

  void showAlertDialog(BuildContext context, TextEditingController controller) async {
    await showDialog(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Full Name', hintText: 'asd',
                ),
              style: TextStyle(
              fontFamily: 'Dot',
              fontSize: 15
              ),
                controller: controller
              ),
            ),
          ],
        ),

        actions: <Widget>[
          FlatButton(
            child: Text(
              'CANCEL',
              style: TextStyle(
              fontFamily: 'Dot',
              fontSize: 15
              ),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          FlatButton(
            child: Text(
              'OK',
              style: TextStyle(
              fontFamily: 'Dot',
              fontSize: 15
              ),
            ),
            onPressed: () {
              addName(controller.text, controller);
              // reLoad();  
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }
}