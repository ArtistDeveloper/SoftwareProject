import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

LetterScreenState pageState;

class LetterScreen extends StatefulWidget {
  @override
  LetterScreenState createState() {
    pageState = LetterScreenState();
    return pageState;
  }
}

class LetterScreenState extends State<LetterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String colName = "Letterplease";

  // 필드명
  final String fnName = "name";
  final String fnDescription = "context";
  final String fnDatetime = "send-time";
  final String fnDate = "receive-time";

  TextEditingController _newNameCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();
  TextEditingController _newyearCon = TextEditingController();

  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();
  TextEditingController _undyearCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // resizeToAvoidBottomPadding: false,
      body: 
      
      Container(
        height: 550,
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              
               Container(
                    width: 180.0,
                    child: TextField(
                      style: TextStyle(fontFamily: 'Dot',
                      fontSize: 20),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      controller: _newyearCon,
                      decoration: InputDecoration(
                        labelText: "날짜",
                        hintText: 'YYYYMMDD',
                        counterText: "",
                      ),
                    ),
                  ),
                   Container(
                        height: 10,
                      ),
            
            TextField(
                style: TextStyle(fontFamily: 'Dot',
                fontSize: 20),
                maxLines: null,
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: "제목"),
                controller: _newNameCon,
              ),
               Container(
                        height: 10,
                      ),

        Expanded(
          
          child: TextField(
                style: TextStyle(fontFamily: 'Dot',
                fontSize: 20),
                maxLines: 5,
                decoration: InputDecoration(labelText: "내용"),
                controller: _newDescCon,
              ),
              ),
              


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ 
                  
                  Expanded(
                    child: IconButton(
                    icon: Icon(Icons.refresh, color: Colors.black54),
                    iconSize: 40,
                    onPressed: () {
                      _newNameCon.clear();
                      _newDescCon.clear();
                      _newyearCon.clear();
                    },
                  ),
                  ),
                 
                  
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.green),
                      iconSize: 40,
                      onPressed: () {
                        if (_newDescCon.text.isEmpty ||
                            _newNameCon.text.isEmpty ||
                            _newyearCon.text.isEmpty ) {
                          Scaffold.of(context).showSnackBar(
                            
                              SnackBar(content: Text("빈칸을 모두 채워주세요.",
                              
                             style: TextStyle(fontFamily: 'Dot',
                fontSize: 18),)));
                        } else if (_newyearCon.text.length != 8) {

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("2020년 6월 08일 = 20200608",
                              style: TextStyle(fontFamily: 'Dot',
                              fontSize: 20),
                              )));

                        } else {

                          createDoc(_newNameCon.text, _newDescCon.text, _newyearCon.text);

                          _newNameCon.clear();
                          _newDescCon.clear();
                          _newyearCon.clear();

                          letters();
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: IconButton(
                      icon: Icon(Icons.email, color: Colors.teal),
                      iconSize: 40,
                      onPressed: () {
                        _newNameCon.clear();
                        _newDescCon.clear();
                        _newyearCon.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => letters()),
                        );
                      },
                    ),
                  ),
                ),
                   


                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }


  Widget letters() {
    print('letters');
    return ListView(
        children: <Widget>[
          Container(
            height: 630,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(colName)
                  .orderBy(fnDatetime, descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...", 
                              style: TextStyle(
                                           fontFamily: 'Dot',));
                  default:
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            // Read Document
                            onTap: () {
                              showUpdateOrDeleteDocDialog(document);
                            },
                            // Update or Delete Document
                            onLongPress: () {
                              _showDialog(document);
                              
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[                                  
                                  Row(                                    
                                    mainAxisAlignment:                                        
                                    MainAxisAlignment.spaceBetween,                                    
                                    children: <Widget>[                                      
                                      Text(                                        
                                        document[fnName],
                                        style: TextStyle(
                                          color: Colors.lightGreen[600],
                                           fontFamily: 'Dot',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("${document[fnDate]}의 나에게",
                                        
                                        style:
                                            TextStyle(color: Colors.green[100],
                                              fontFamily: 'Dot',
                                              fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      document[fnDescription],
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontFamily: 'Dot',
                                        fontSize: 19),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          )
        ],
      );
    // Create Document
  }

  /// Firestore CRUD Logic

  // 문서 생성 (Create)
  void createDoc(String name, String description, String date) {
    Firestore.instance.collection(colName).add({
      fnName: name,
      fnDescription: description,
      fnDate: date,
      fnDatetime: Timestamp.now(),
    });
  }

 
  // 문서 갱신 (Update)
  void updateDoc(String docID, String name, String description, String date) {
    Firestore.instance.collection(colName).document(docID).updateData({
      fnName: name,
      fnDescription: description,
      fnDate: date,
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance.collection(colName).document(docID).delete();
  }
void _showDialog(DocumentSnapshot doc) { 
    showDialog(
      context: context,
      barrierDismissible: false,  
      builder: (BuildContext context) { 
        return AlertDialog(
          title: Text("정말로 삭제하시겠습니까?",
           style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 18),),
          content: SingleChildScrollView(child:new Text("삭제된 편지는 되돌아 오지 않습니다.",
          style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 13))),
          actions: <Widget>[ 
             FlatButton(
              child: new Text("취소", style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 13)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
             FlatButton(
              child: new Text("삭제", style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 13)),
              onPressed: () {
                deleteDoc(doc.documentID);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
    /* _newNameCon.text = doc[fnName];
    _newDescCon.text = doc[fnDescription];
    _newyearCon.text = doc[fnDate];

    Navigator.pop(context);
 */

    _undNameCon.text = doc[fnName];
    _undDescCon.text = doc[fnDescription];
    _undyearCon.text = doc[fnDate];

    

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        
        return AlertDialog(
          
          title: Center(
            child: Text("LETTER",style: TextStyle(fontFamily: 'Dot',
                fontSize: 23,)),),
          content: Container(
            height: 150,
            width: 50,
            child: Column(
              children: <Widget>[
                 Expanded(  child:  
                TextField(
                   style: TextStyle(fontFamily: 'Dot',
                fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'YYYYMMDD',
                        counterText: "",
                      ),
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      controller: _undyearCon,
                    ),
                 ),
                 //Expanded( child: 
                TextField(
                   style: TextStyle(fontFamily: 'Dot',
                fontSize: 15),
                  decoration: InputDecoration(labelText: "제목"),
                  controller: _undNameCon,
                ),
                //),
                
                 TextField(
                   style: TextStyle(fontFamily: 'Dot',
                fontSize: 15),
                maxLines: null,
                  decoration: InputDecoration(labelText: "내용"),
                  controller: _undDescCon,
                )
              
              ],
            ),
          ),
          actions: <Widget>[
             FlatButton(
              child: Text("취소", style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 15)),
              onPressed: () {
                _undNameCon.clear();
                _undDescCon.clear();
                Navigator.pop(context);
              },
            ),
           FlatButton(
                child: Text("수정", style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 15)),
                onPressed: () {
                 
                    updateDoc(doc.documentID, _undNameCon.text,
                        _undDescCon.text, _undyearCon.text);

                    _undNameCon.clear();
                    _undDescCon.clear();
                    _undyearCon.clear();
                    Navigator.pop(context);
                  
                }),
                FlatButton(
              child: Text("삭제", style: TextStyle(color: Colors.black, fontFamily: 'Dot', fontSize: 15)),
              onPressed: () {
                deleteDoc(doc.documentID);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    ); 
  }

  
}