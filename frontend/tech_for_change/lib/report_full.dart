import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:card_settings/widgets/text_fields/card_settings_text.dart';
import 'package:flutter/material.dart';
import './report_data.dart';
class ReportFull extends StatelessWidget {

  final DataReport data;

  ReportFull({Key key, @required this.data}) : super(key : key);

  @override
  Widget build(BuildContext context) {
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

  final DataReport data;

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
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  reportRow('Disease', widget.data.result),
                  SizedBox(
                    height: 10.0,
                  ),
                  CardSettingsHeader(label: "Date",),
                  SizedBox(
                    height: 10.0,
                  ),
                  reportRow('Date', widget.data.date),
                  SizedBox(
                    height: 10.0,
                  ),
                  CardSettingsHeader(label: "Personal Info",),
                  SizedBox(
                    height: 10.0,
                  ),
                  reportRow('Gender', widget.data.gender),
                  Divider(),
                  reportRow('Age', widget.data.age),
                  Divider(),
                  reportRow('Height', widget.data.height.toString()),
                  Divider(),
                  reportRow('Weight', widget.data.weight.toString()),
                  SizedBox(
                    height: 10.0,
                  ),
                  CardSettingsHeader(label: "Diagnosis",),
                  SizedBox(
                    height: 10.0,
                  ),
                  reportRow('Symptoms', widget.data.symptoms),
                  Divider(),
                  reportRow('Other Remarks', widget.data.remarks),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}