import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:planbreaker/widget/WiseSaying.dart';

class AppState {
  bool loading;
  FirebaseUser user;
  AppState(this.loading, this.user);
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final app = AppState(false, null);
  @override
  Widget build(BuildContext context) {
    if (app.loading) return _loading();
    if (app.user == null) return _logIn();
    Navigator.pop(context);
    return WiseSaying();
  }
  Widget _loading () {
    return Scaffold(
        body: Center(child: CircularProgressIndicator())
    );
  }
  
  Widget _logIn () {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("images/pb.png"), height: 150),
                // FlutterLogo(size: 150),
                //SizedBox(height: 50),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.lightBlue)
                    ),
                    color: Colors.white,
                    textColor: Colors.lightBlue,
                    
                    child: Text(
                      'Sign in with Google', 
                      style: TextStyle(
                      fontSize: 20)
                    ),
                    
                    onPressed: () {
                      _signIn();
                    }
                )
              ],
            )
        )
    );
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _signIn() async {
    setState(() => app.loading = true);
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    print(user);

    setState(() {
      app.loading = false;
      app.user = user;
    });

    return 'success';
  }

  //로그아웃 환경설정에 추가?

  // void _signOut() async{
  //   await googleSignIn.signOut();
  //   // await _auth.signOut();
  //   setState(() {
  //     app.user = null;
  //   });
  // }
  
}