import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tech_for_change/auth_state.dart';
import 'package:tech_for_change/login_page.dart';
import 'package:tech_for_change/register_page.dart';

class LandingPage extends StatelessWidget {
  final StreamController<AuthenticationState> _streamController;

  LandingPage(this._streamController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.0,
            ),
            Image.asset('assets/images/logo.jpg'),
            SizedBox(
              height: 200.0,
            ),
            SizedBox(
              width: 250.0,
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => LoginPage(_streamController))
                  );
                },
                color: Colors.lightBlue[900],
                padding: EdgeInsets.fromLTRB(80.0, 15.0, 80.0, 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
              width : 250.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RegPage())
                  );
                },
                color: Colors.lightBlue[900],
                padding: EdgeInsets.fromLTRB(80.0, 15.0, 80.0, 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),    
          ],
        ),
      ),
    );
  }
}