import 'dart:async';
import "package:flutter/material.dart";
import 'package:tech_for_change/auth_state.dart';
import 'package:tech_for_change/dashboard.dart';
import 'package:tech_for_change/landing_page.dart';

class BuilderPage extends StatelessWidget {
  final StreamController<AuthenticationState> _streamController = new StreamController<AuthenticationState>.broadcast();

  Widget buildUI(BuildContext context, AuthenticationState authState){
    print(authState.authenticated);
    if(authState.authenticated){
      return Dashboard(_streamController);
    }
    else{
      return LandingPage(_streamController);
    }
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