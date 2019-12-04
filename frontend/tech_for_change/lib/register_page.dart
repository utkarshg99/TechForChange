import 'package:flutter/material.dart';

class RegPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      resizeToAvoidBottomPadding: false,
      body: WillPopScope(
        onWillPop: () async {
          Future.value(false);
        },
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 50.0
                    ),
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.black45,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.black45,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.black45,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.lock_open,
                                    color: Colors.white,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.black45,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.lock_open,
                                    color: Colors.white,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        RaisedButton(
                          onPressed: (){},
                          color: Colors.deepPurple[400],
                          padding: EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
}