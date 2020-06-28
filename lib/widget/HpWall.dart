import 'package:flutter/material.dart';

class HpWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    //360, 592 탭바를 제외한 화면 사이즈
    return Positioned(
      width: size.width, 
      height: 50,
       top: 40,
      child: Container(
      // color: Colors.amberAccent,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/wallHp/wallHp_sample.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    ); 
  }
}
