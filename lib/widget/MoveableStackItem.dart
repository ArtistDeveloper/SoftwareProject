import 'package:flutter/material.dart';

import 'package:planbreaker/data/MoveableData.dart';
import 'package:planbreaker/data/TodoListData.dart';
import 'package:provider/provider.dart';

class MoveableStackItem extends StatefulWidget {
  //final String blockName;
  final int moveableStackItemCount;
  final String moveableName;
  MoveableStackItem({Key key, this.moveableName, this.moveableStackItemCount}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  // bool get wantKeepAlive => true; with AutomaticKeepAliveClientMixin
  List tempList = [];
  double xPosition = 10;
  double yPosition = 50;

  @override
  void initState() {
    super.initState();
    print('Moveable init');
    
    print('moveableStackItem Count : ' + '${widget.moveableStackItemCount}');
  }

  void dispose() {
    print('Moveable dispose');
    super.dispose();
  }

  // void posReturn() {
  //   HomeView.of(context).tempXposition[widget.count] = xPosition;
  //   HomeView.of(context).tempYposition[widget.count] = yPosition;
  // }

  @override
  Widget build(BuildContext context) {
    final MoveableProvider moveableData = Provider.of<MoveableProvider>(context, );

    return Builder(
      builder: (context) => Positioned(
        top: yPosition,
        left: xPosition,
        child: GestureDetector(
          onTap: () async {
            // Navigator.pop(context);
            await Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => TodoListView()),
              MaterialPageRoute(builder: (context) => moveableData.todoList[widget.moveableStackItemCount]), //이부분이 잘못되면 AppBar이름이 이상해짐,.
            );
          },
          onPanUpdate: (tapInfo) {
            //TodoPack 이동기능.
            setState(() {
              xPosition += tapInfo.delta.dx;
              yPosition += tapInfo.delta.dy;
            });
          },
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/block/cloud.png"),
                  fit: BoxFit.cover),
            ),
            //child: Center(child: Text($blockName)), // moveableitem의 각 이름으로 적용되게 만들기.
            child: Center(
              child: Text(
                // moveableData.moveableNames[moveableData.nameCounter], //rebuild되면 값이 다 바뀜
                widget.moveableName,
                style: TextStyle(
              fontFamily: 'Dot',
              fontSize: 18
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
