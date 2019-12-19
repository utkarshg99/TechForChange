import 'dart:async';
import "package:flutter/material.dart";
import 'package:tech_for_change/auth_state.dart';
import 'package:tech_for_change/dashboard.dart';
import 'package:tech_for_change/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_for_change/url.dart';

class BuilderPage extends StatefulWidget {
  @override
  _BuilderPageState createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  final StreamController<AuthenticationState> _streamController = new StreamController<AuthenticationState>.broadcast();

  bool _loading = true;
  AuthenticationState authS = AuthenticationState.initial();

  Widget buildUI(BuildContext context, AuthenticationState authState){
    // print(authState);
    if(authState.authenticated){
      return Dashboard(_streamController);
    }
    else{
      return LandingPage(_streamController);
    }
  }

  Future getValueSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("login")){
      if(prefs.getBool("login")){
        print('hello');
        authS = AuthenticationState.authenticated();
        return;
      }
    }
  }

  @override
  void initState(){
    _loading = true;
  }

  @override
  Widget build(BuildContext context) {
    if(_loading){
      fetchURL().then((value) {
        getValueSF().then((value) {
          setState(() {
            _loading = false;
          });
        });
      });
    }
    if(_loading){
      return(Container(
        color: Colors.white,
        child: Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
          )
        )
      );
    }
    else{
      return new StreamBuilder<AuthenticationState>(
        stream: _streamController.stream,
        initialData: authS,
        builder: (BuildContext context, AsyncSnapshot<AuthenticationState> snapshot){
          final state = snapshot.data;
          return buildUI(context, state);
        },
      );
    }
  }
}