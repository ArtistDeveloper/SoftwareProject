import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        height: 50,
        child: TabBar( 
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.transparent,
            tabs: <Widget>[
                Tab(
                icon: Image.asset(
                  'images/bottombar/home.png',
                ),
              ),

              Tab(
                icon: Image.asset(
                  'images/bottombar/letter.png',
                  //fit: BoxFit.fitWidth
                 ),
              ),

              Tab(
                icon: Image.asset(
                  'images/bottombar/setting.png'
                ),
              ),
            ],
          ),
        );
  }
}
