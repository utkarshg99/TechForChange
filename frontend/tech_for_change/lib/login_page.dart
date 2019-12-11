import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tech_for_change/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatelessWidget {

  final StreamController<AuthenticationState> _streamController;
  LoginPage(this._streamController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      resizeToAvoidBottomPadding: false,
      body: LoginForm(_streamController),
    );
  }
}
class LoginForm extends StatefulWidget {

  final StreamController<AuthenticationState> _streamController;
  LoginForm(this._streamController);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", true);
    prefs.setString("uid", _email);

    var response = await http.post(
      Uri.encodeFull('http://ec2-54-161-90-53.compute-1.amazonaws.com/getUser'),
      headers: {
        'Content-Type' : 'application/json',
      },
      body: json.encode({'email' : _email}),
    );

    Map data = json.decode(response.body);
    print(data);
    if(data['status']){
      print(data['data']);
      prefs.setInt("age", data['data']['age']);
      prefs.setString("gender", data['data']['gender']);
      prefs.setString("name", data['data']['name']);
      prefs.setString('phone', data['data']['phone']);
    }
    print('hello');
    widget._streamController.add(AuthenticationState.authenticated());
    Navigator.of(context).pop();
  }

  Future<String> getLogin() async {

    Map inputData = {
      "email" : _email,
      "pass" : _password
    };

    var body = json.encode(inputData);
    // print(body);
    var response = await http.post(
      Uri.encodeFull('http://ec2-54-161-90-53.compute-1.amazonaws.com/login'),
      headers: {
        "Content-Type" : "application/json",
      },
      body: body
    );

    Map data = json.decode(response.body);
    print(data);
    if(data["status"]){
      print('login');
      login();
    }
    else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Login Not Successful'),));
    }
  }

  loginUser(context){
    if(_formKey.currentState.validate()){
      Scaffold.of(context).showSnackBar(SnackBar(content : Text('Processing Data')));
      _formKey.currentState.save();
      getLogin();
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                      fontSize: 50.0,
                      color: Colors.white
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
                            loginUser(context);
                          },
                          color: Colors.lightBlue[900],
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
      );
  }
}