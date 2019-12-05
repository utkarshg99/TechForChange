import 'dart:async';
import "package:flutter/material.dart";
import 'package:tech_for_change/auth_state.dart';

class BuilderPage extends StatelessWidget {
  final StreamController<AuthenticationState> _streamController = new StreamController<AuthenticationState>();

  Widget buildUI(BuildContext context, AuthenticationState authState){
    // if(authState.authenticated){
    //   return 
    // }
    // else{
    // }
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