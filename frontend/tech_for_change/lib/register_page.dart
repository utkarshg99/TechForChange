import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      resizeToAvoidBottomPadding: false,
      body: RegForm(),
    );
  }
}

class RegForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  
  final _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _confirm;

  registerUser(){
    print(_formKey.currentState.validate());
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Scaffold.of(context).showSnackBar(SnackBar(content : Text('Processing Data')));
      getData();
    }
  }

  Future<String> getData() async {
    Map inputData = {
      'pass' : _password,
      'email' : _email,
      'name' : _name,
    };

    var body = json.encode(inputData);

    var response = await http.post(
      Uri.encodeFull("http://tfc-app.herokuapp.com/makeUser"),
      body: body,
      headers: {
        "Content-Type" : "application/json"
      }
    );
    
    Map data = json.decode(response.body);
    
    if(data["status"]){
      Navigator.of(context).pop();
    }
    else{
      Scaffold.of(context).showSnackBar(SnackBar(content : Text('Email ID already registered')));
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
                  "Register",
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
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.black45,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: (value) => value.isEmpty ? "Name cannot be blank" : null,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              onSaved: (value){
                                _name = value;
                              },
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
                              onSaved: (value) {
                                _email = value;
                              },
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
                              onSaved: (value) {
                                _password = value;
                              },
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
                              onSaved: (value) {
                                _confirm = value;
                              },
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
                        onPressed: (){
                          registerUser();
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