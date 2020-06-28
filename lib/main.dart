import 'package:flutter/material.dart';
import 'package:planbreaker/screen/Tab_Screen.dart';
import 'package:planbreaker/screen/login_screen.dart';

import 'package:planbreaker/data/TodoListData.dart';
import 'package:planbreaker/data/MoveableData.dart';
import 'package:planbreaker/data/CloudBoomData.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

//따로 state를 관리하는 class를 하나 만들자. 이 부분은 값이 회수되지 말아야함.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => TodoListProvider(),
        ),
        ChangeNotifierProvider(
          builder: (_) => MoveableProvider(),
        ),
        ChangeNotifierProvider(
          builder: (_) => CloudBoomProvider(),
        ),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}