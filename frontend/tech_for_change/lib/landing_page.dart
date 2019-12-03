import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.0,
            ),
            Icon(
              Icons.local_hospital,
              size: 120.0,
            ),
            SizedBox(
              height: 200.0,
            ),
            RaisedButton(
              onPressed: (){},
              color: Colors.deepPurple[400],
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
            SizedBox(
              height: 50.0,
            ),
            RaisedButton(
              onPressed: (){},
              color: Colors.deepPurple[400],
              padding: EdgeInsets.fromLTRB(80.0, 15.0, 80.0, 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
            ),    
          ],
        ),
      ),
    );
  }
}