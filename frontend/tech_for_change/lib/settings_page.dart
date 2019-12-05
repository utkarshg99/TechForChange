import 'dart:async';

import "package:flutter/material.dart";
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:tech_for_change/auth_state.dart';

class SettingsPage extends StatefulWidget {

  final StreamController<AuthenticationState> _streamController;

  SettingsPage(this._streamController);

  @override
  _SettingsPageState createState() => _SettingsPageState(this._streamController);
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  StreamController<AuthenticationState> _streamController;

  _SettingsPageState(this._streamController);

  changeTheme() async {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  }

  void passFunc(){

  }

  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext){
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirm"),
              onPressed: () => _streamController.add(AuthenticationState.signedOut()) ,
            ),
          ],
        );
      }
    );
  }

  Widget settingsRow(bool isSwitched, String title, void onPress()){
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title
          ),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
              onPress();
            },
            activeColor: Colors.deepPurple[600],
            activeTrackColor: Colors.deepPurple[300],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              settingsRow(Theme.of(context).brightness == Brightness.dark ? true : false, "Dark Theme", changeTheme),
              settingsRow(false, "Notifications", passFunc),
              RaisedButton(
                child: Text("Logout"),
                onPressed: (){
                  _streamController.add(AuthenticationState.signedOut());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}