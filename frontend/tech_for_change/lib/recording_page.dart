import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';

class RecPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecordPage(),
    );
  }
}

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  String _gender;
  int _age;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key : _formKey,
        child: CardSettings(
          children: <Widget>[
            CardSettingsHeader(label: 'New Report',),
            CardSettingsDatePicker(
              label: 'Date',
              visible: true,                          
            ),
            CardSettingsHeader(label: "Personal Info",),
            CardSettingsListPicker(
              label: "Gender",
              initialValue: _gender,
              options: ["Male", "Female"],
              onChanged: (value){
                setState(() {
                  _gender = value;
                });
              },
            ),
            CardSettingsNumberPicker(
              label: "Age",
               min: 0,
               max: 100,
               initialValue: _age,
               onChanged: (value){
                 setState(() {
                   _age = value;
                 });
               },
            ),
            CardSettingsDouble(
              label: "Height",
              unitLabel: "m",
              initialValue: 0,
            ),
            CardSettingsInt(
              label: "Weight",
              unitLabel: "kg",
            ),
            CardSettingsHeader(label: "Diagnosis",),
            CardSettingsMultiselect(
              label: "Symptoms",
              options: <String>['Fever', 'Headache'],
              initialValues: <String>['Fever'],
            ),
          ],
        ),
      ),
    );
  }
}