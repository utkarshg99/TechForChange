import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_uploader/flutter_uploader.dart';


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

  final uploader = FlutterUploader();

  String _fileName;
  String _gender;
  int _age;
  double _height;
  int _weight;
  List<String> _symptoms;
  String _remarks;
  DateTime _date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void record_audio_start() async {
    bool hasPermissions = await AudioRecorder.hasPermissions;
    bool isRecording = await AudioRecorder.isRecording;
    if(hasPermissions && !isRecording){
      startStopWatch();
      var rng = new Random();
      _fileName = 'Recording_' + rng.nextInt(10000000).toString();
      await AudioRecorder.start(path : 'sdcard/' + _fileName +'.mp4', audioOutputFormat: AudioOutputFormat.AAC);
    }
  }

  void record_audio_stop() async {
    stopStopWatch();
    Recording recording = await AudioRecorder.stop();
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
  }

  submitFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _email = prefs.getString('uid');

    final taskId = await uploader.enqueue(
      url : 'https://tfc-app.herokuapp.com/putAudio',
      files: [FileItem(filename: _fileName+'.mp4', savedDir: 'sdcard', fieldname: 'audio')],
      method: UploadMethod.POST,
      headers: {'Content-Type' : 'multipart/form-data',},
      data: {
        'date' : _date.toString(),
        'uid' : _email,
        'age' : _age.toString(),
        'gender' : _gender.toString(),
        'weight' : _weight.toString(),
        'height' : _height.toString(),
        'symptoms' : _symptoms.toString(),
        'remark' : _remarks
      },
      showNotification: false,
      tag: 'upload_audio',
    );

    final subscription = uploader.result.listen((result) {
      print(result);
      Navigator.of(context).pop();
    }, onError: (ex, stacktrace) {
      print(ex + stacktrace);
    });
  }

  bool startisPressed = true;
  bool stopisPressed = true;
  String timeToDisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void startTime(){
    Timer(dur, keepRunning);
  }

  void keepRunning(){
    if(swatch.isRunning){
      startTime();
    }
    setState(() {
      timeToDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") + ':' + (swatch.elapsed.inMinutes%60).toString().padLeft(2, '0') + ':' + (swatch.elapsed.inSeconds%60).toString().padLeft(2, '0');
    });
  }

  void startStopWatch(){
    setState(() {
      stopisPressed = false;
      startisPressed = false;
    });
    swatch.start();
    startTime();
  }

  void stopStopWatch(){
    setState(() {
      stopisPressed = true;
    });
    swatch.stop();
  }

  Widget stopwatch(){
    return Container(
      alignment: Alignment.center,
      child: Text(
        timeToDisplay,
        style : TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        )
      ),
    );
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
                      onSaved: (value) {
                        _date = value;
                      },                       
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
                      onSaved: (value) {
                        _gender = value;
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
                      onSaved: (value) {
                        _age = value;
                      }
                    ),
                    CardSettingsDouble(
                      label: "Height",
                      unitLabel: "m",
                      initialValue: 0,
                      onSaved: (value) {
                        _height = value;
                      },
                    ),
                    CardSettingsInt(
                      label: "Weight",
                      unitLabel: "kg",
                      onSaved: (value) {
                        _weight = value;
                      },
                    ),
                    CardSettingsHeader(label: "Diagnosis",),
                    CardSettingsMultiselect(
                      label: "Symptoms",
                      options: <String>['Fever', 'Headache'],
                      initialValues: <String>['Fever'],
                      onSaved: (value) {
                        _symptoms = value;
                      },
                    ),
                    CardSettingsParagraph(
                      label: 'Other Remarks',
                      onSaved: (value) {
                        _remarks = value;
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        stopwatch(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width : 140.0,
                              child : RaisedButton(
                                onPressed: startisPressed ? record_audio_start : null,
                                color: Colors.green,
                                child: Text(
                                  "Start Recording",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),  
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ), 
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Container(
                              width: 140.0,
                              child: RaisedButton(
                                onPressed: stopisPressed ? null : record_audio_stop,
                                color : Colors.red,
                                child: Text(
                                  "Stop Recording",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          onPressed: () {
                            submitFormData();
                          },
                          child: Text(
                            "Submit"
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
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