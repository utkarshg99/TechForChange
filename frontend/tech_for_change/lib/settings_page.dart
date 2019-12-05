import "package:flutter/material.dart";
import 'package:dynamic_theme/dynamic_theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void changeTheme(){
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  }

  void passFunc(){

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
                onPressed: (){},
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}