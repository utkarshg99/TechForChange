import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tech_for_change/auth_state.dart';
import 'package:tech_for_change/landing_page.dart';

class LoginPage extends StatefulWidget {
  
  final StreamController<AuthenticationState> _streamController;


  LoginPage(this._streamController);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  login() async {
    widget._streamController.add(AuthenticationState.authenticated());
  }

  Future<String> getLogin() async {
    var response = await http.post(
      Uri.encodeFull(''),
      headers: {
        "Accepted" : "application/json",
      },
      body: {
        "email" : _email,
        "pass" : _password,
      }
    );

    print(response);
  }

  loginUser(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Scaffold.of(context).showSnackBar(SnackBar(content : Text('Processing Data')));
      getLogin();
    }
  }

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
                    "Login",
                    style: TextStyle(
                      fontSize: 50.0
                    ),
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.black45,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                validator: (value) => (value.isEmpty) ? "Required Field" : null,
                                onSaved: (value){
                                  _email = value;
                                },
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
                                validator: (value) => (value.isEmpty) ? "Required Field" : null,
                                onSaved: (value){
                                  _password = value;
                                },
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
                        SizedBox(
                          height: 35.0,
                        ),
                        RaisedButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                            login();
                          },
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