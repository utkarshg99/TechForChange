import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:audio_recorder/audio_recorder.dart';

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

  void record_audio_start() async {
    bool hasPermissions = await AudioRecorder.hasPermissions;
    bool isRecording = await AudioRecorder.isRecording;
    if(hasPermissions && !isRecording){
      await AudioRecorder.start(path : 'sdcard/newfile.mp4', audioOutputFormat: AudioOutputFormat.AAC);
    }
  }

  void record_audio_stop() async {
    Recording recording = await AudioRecorder.stop();
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
  }

  submitFormData() async {
    null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Future.value(false);
      },
      child: Container(
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
            Container(
              height: 700.0,
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
                    CardSettingsParagraph(
                      label: 'Other Remarks',
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            record_audio_start();
                          },
                          child: Text("Start Recording"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            record_audio_stop();
                          },
                          child: Text(
                            "Stop Recording"
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            submitFormData();
                          },
                          child: Text(
                            "Submit"
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ) 
      ),
    ); 
  }
}