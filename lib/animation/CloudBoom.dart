import 'package:flutter/material.dart';
import 'package:planbreaker/data/CloudBoomData.dart';
import 'package:provider/provider.dart';

class CloudBoom extends StatefulWidget {
  final String cloudName;
  CloudBoom({this.cloudName});

  @override
  _CloudBoomState createState() => _CloudBoomState();
}

class _CloudBoomState extends State<CloudBoom> {
  var alignment = Alignment.bottomCenter;

  Widget boomerCreate() {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            alignment = alignment == Alignment.bottomCenter
                //이렇게 좌표값을 읽어온다던가 할수 있
                ? Alignment.topCenter
                : Alignment.bottomCenter;
          });
        },
        child: AnimatedAlign(
          alignment: alignment,
          duration: Duration(milliseconds: 1000), //속도도
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
                widget.cloudName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Dot',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CloudBoomProvider boomData = Provider.of<CloudBoomProvider>(
      context,
    );
    return boomData.boom = boomerCreate();
  }
}
