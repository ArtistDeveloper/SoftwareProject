import 'package:flutter/material.dart';


class Setting extends StatefulWidget { 
  
  @override 
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  bool toggleValue = true;

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      Padding(
      padding: EdgeInsets.all(32.0),
      child: ListView(   
        children: <Widget>[
          
          // ListTile(
          //   title: 
          //   Text('테마 변경',
          //   style: TextStyle(fontSize: 20),
          //   ),

          //   trailing : Icon(Icons.navigate_next,
          //   size: 30.0,),
          //     onTap: () => 
          //       Navigator.push(
          //         context,
          //       MaterialPageRoute(
          //         builder: (context) => Tema(),
          //         ),
          //       ),
          // ),
          
      Row(
        children: <Widget>[

          Text('   명언',
          style: TextStyle(fontSize: 20),
            ),
          //명언 on/off 애니메이션 일단 넣음 기능은 공부해서 적용하도록
         
          Padding(
            padding: EdgeInsets.only(left: 130) ,
            child: AnimatedContainer(
              
              duration: Duration(milliseconds: 500),
              height: 40.0,
              width: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: toggleValue
                      ? Colors.greenAccent[100]
                      : Colors.redAccent[100].withOpacity(0.5)),
              child: Stack(children: <Widget>[
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: 3.0,
                  left: toggleValue ? 60.0 : 0.0,
                  right: toggleValue ? 0.0 : 60.0,
                  child: InkWell(
                    onTap: toggleButton,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return RotationTransition(child: child, turns: animation);
                      },
                      child: toggleValue
                          ? Icon(Icons.check_circle,
                              color: Colors.green, size: 35.0, key: UniqueKey())
                          : Icon(Icons.remove_circle_outline,
                              color: Colors.red, size: 35.0, key: UniqueKey()),
                              
                    ),
                  ),
                )
              ]
            ),
            ),
          ),
        ]
      )
                ],
            ),
    
    ),
    
    );
}
}



//````````````````````````````````````//

class Tema extends StatefulWidget {
  @override
  _TemaState createState() => _TemaState();
}

class _TemaState extends State<Tema> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
      Padding(
      padding: EdgeInsets.all(32.0),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.flight_land),
            title: Text('지하로 가고 싶어'),
              onTap: () => 
                Setting(),//테마1로 바꾸게
          ),
          
          ListTile(
            leading: Icon(Icons.flight_takeoff),
            title: Text('지상으로 가고 싶어'),
              onTap: () => 
                Setting(),//테마2로 바꾸게
          ),

                ],
            ),
      ),
        );
    }
  }