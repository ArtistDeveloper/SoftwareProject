import 'package:flutter/material.dart';
import 'package:planbreaker/widget/HomeView.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true; //TabBar 정보 유지.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Container(
        child: HomeView(),
      )
    );
  }
}

class MyPopupMenu extends StatefulWidget {
  @override
  _MyPopupMenuState createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu> {
  var _tapPosition;

  void _showCustomMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    //print('hihi');
    showMenu(
      context: context, 
      position: RelativeRect.fromRect(
        _tapPosition & Size(40, 40), 
         Offset.zero & overlay.size), 
      items: <PopupMenuEntry<int>>[AddDeleteEntry()],
      );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onLongPress: _showCustomMenu,
      onTapDown: _storePosition,
    );
  }
}


class AddDeleteEntry extends PopupMenuEntry<int> {
  @override
  final double height = 100;

  @override
  bool represents(int n) => n == 1 || n == -1;

  @override
  _AddDeleteEntryState createState() => _AddDeleteEntryState();
}

class _AddDeleteEntryState extends State<AddDeleteEntry> {
  Widget _add() {
    print('hihi');
   
    //Navigator.pop(context, 1);
    //여기서 추가를 해서, homescreenstate에 폴더가 추가되야함.
  }

  // void _delete() {

  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: FlatButton(onPressed: _add, child: Text('추가'))), //onpressed에 바로 클래스 넣어버리기
        //Expanded(child: Text('삭제', textAlign: TextAlign.center,)),
        Expanded(child: Text('삭제', textAlign: TextAlign.center,)),
      ],
    );
  }
}