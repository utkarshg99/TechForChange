import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:card_settings/widgets/text_fields/card_settings_text.dart';
import 'package:flutter/material.dart';
import './report_data.dart';
class ReportFull extends StatelessWidget {

  Map data;

  ReportFull({Key key, @required this.data}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    print(this.data);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon : Icon(
            Icons.arrow_back,
          )
        ),
      ),
      body: ReportCard(data: this.data,),
    );
  }
}

class ReportCard extends StatefulWidget {  

  Map data;

  ReportCard({Key key, @required this.data}) : super(key : key);

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {

  Widget reportRow(String label, String data){
    return Container(
      padding: EdgeInsets.fromLTRB(13.0, 5.0, 10.0, 5.0),
      child : Row(
        children: <Widget>[
          Container(
            width: 200.0,
            child: Text(label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0
            ),),
          ),
          Container(
            child: Text(
              data,
              style: TextStyle(
                fontSize: 17.0
              ),
              overflow: TextOverflow.fade,
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    print(widget.data);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 700,
            child: Form(
              child: CardSettings(
                children: <Widget>[
                  CardSettingsHeader(label: "Result",),
                  SizedBox(
                    height: 10.0,
                  ),
                  Visibility(
                    visible: (widget.data['final'].toString().split(' ')[1]=='False' && widget.data['final'].toString().split(' ')[4]=='False') ? true : false,
                    child: reportRow('Condition', (widget.data['final'].toString().split(' ')[1]=='False' && widget.data['final'].toString().split(' ')[4]=='False') ? 'Healthy' : 'Unhealthy'),
                  ),
                  Visibility(
                    visible: (widget.data['final'].toString().split(' ')[1]=='False' && widget.data['final'].toString().split(' ')[4]=='False') ? true : false,
                    child: Divider(),
                  ),
                  reportRow('Crackles', widget.data['final'].toString().split(' ')[1]),
                  Divider(),
                  reportRow('Wheezes', widget.data['final'].toString().split(' ')[4]),
                  Visibility(
                    visible: (widget.data['final'].toString().split(' ')[1]=='False' && widget.data['final'].toString().split(' ')[4]=='False') ? false : true,
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        reportRow('Possible Diseases', ''),
                        Visibility(
                          visible: (widget.data['final'].toString().split(' ')[1]=='False' && widget.data['final'].toString().split(' ')[4]=='True') ? true : false,
                          child: Padding(
                            padding : EdgeInsets.fromLTRB(13.0, 5.0, 10.0, 5.0),
                            child: Text("Asthma, Bronchiectasis, COPD"),
                          ),
                        ),
                        Visibility(
                          visible: (widget.data['final'].toString().split(' ')[1]=='True' && widget.data['final'].toString().split(' ')[4]=='True') ? true : false,
                          child: Padding(
                            padding : EdgeInsets.fromLTRB(13.0, 5.0, 10.0, 5.0),
                            child : Text("Asthma, Bronchiectasis, COPD, URTI, Tubercolosis, Bronchiolitis"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CardSettingsHeader(label: "Date",),
                  SizedBox(
                    height: 10.0,
                  ),
                  reportRow('Date', widget.data['date'].toString().split(' ')[0]),
                  SizedBox(
                    height: 10.0,
                  ),
                  CardSettingsHeader(label: "Personal Info",),
                  SizedBox(
                    height: 10.0,
                  ),
                  reportRow('Gender', widget.data['gender']),
                  Divider(),
                  reportRow('Age', widget.data['age'].toString()),
                  Divider(),
                  reportRow('Height', widget.data['height'].toString()),
                  Divider(),
                  reportRow('Weight', widget.data['weight'].toString()),
                  Divider(),
                  reportRow("BMI", widget.data['bmi'].toString().split('.')[0]+'.'+widget.data['bmi'].toString().split('.')[1][0]),
                  SizedBox(
                    height: 10.0,
                  ),
                  CardSettingsHeader(label: "Diagnosis",),
                  SizedBox(
                    height: 10.0,
                  ),
                  reportRow('Symptoms', widget.data['symptoms'].toString().substring(1, widget.data['symptoms'].toString().length-1)),
                  // Divider(),
                  // reportRow('Other Remarks', ''),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(13.0, 5.0, 10.0, 5.0),
                  //   child : Row(
                  //     children: <Widget>[
                  //       Container(
                  //         width: 200.0,
                  //         child: Text(widget.data['remarks']=='null' ? '' : widget.data['remarks'],
                  //         style: TextStyle(
                  //           fontSize: 17.0
                  //         ),),
                  //       ),
                  //     ],
                  //   )
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}