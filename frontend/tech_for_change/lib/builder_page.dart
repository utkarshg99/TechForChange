import 'dart:async';
import "package:flutter/material.dart";
import 'package:tech_for_change/auth_state.dart';
import 'package:tech_for_change/dashboard.dart';
import 'package:tech_for_change/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuilderPage extends StatefulWidget {
  @override
  _BuilderPageState createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  final StreamController<AuthenticationState> _streamController = new StreamController<AuthenticationState>.broadcast();

  Widget buildUI(BuildContext context, AuthenticationState authState){
    // print(authState);
    if(authState.authenticated){
      return Dashboard(_streamController);
    }
    else{
      return LandingPage(_streamController);
    }
  }

  getValueSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("login")){
      if(prefs.getBool("login")){
        _streamController.add(AuthenticationState.authenticated());
        return;
      }
    }
  }

  @override
  void initState(){
    getValueSF();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<AuthenticationState>(
      stream: _streamController.stream,
      initialData: new AuthenticationState.initial(),
      builder: (BuildContext context, AsyncSnapshot<AuthenticationState> snapshot){
        final state = snapshot.data;
        return buildUI(context, state);
      },
    );
  }
}