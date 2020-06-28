import 'package:flutter/material.dart';
import 'package:planbreaker/screen/home_screen.dart';
import 'package:planbreaker/screen/LetterScreen.dart';  
import 'package:planbreaker/screen/setting_screen.dart';
import 'package:planbreaker/widget/Bottombar.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  TabController _controller;

    void initState(){
      super.initState();
      print('TabScreen initsate');
    }

    void dispose() {
      _controller.dispose();
      print('TabScreen dispose');
      super.dispose();
    }
    
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanBreaker',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
          accentColor: Colors.white),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              LetterScreen(),
              Setting(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}