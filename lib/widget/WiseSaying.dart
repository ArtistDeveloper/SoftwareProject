import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planbreaker/screen/Tab_Screen.dart';

class WiseSaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)
                    ),
                    
      content: StreamBuilder(
          stream: Firestore.instance.collection('wise-saying').snapshots(),
          builder: (context, snapshot){
            if (! snapshot.hasData) return Text("Loading data...");
            return Text(
              snapshot.data.documents[0]['today'],
              style: TextStyle(
                fontSize: 20, color: Colors.white
              )
            );
          }
      ),
    
    actions: [
      FlatButton(
        child: Text(
          "확인",
          style: TextStyle(
            fontSize: 15, color: Colors.white
            )
          ),

      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => TabScreen(),
          )
        );
      }
    ), 
    ],
    backgroundColor: Colors.black,
  );
  }
}
