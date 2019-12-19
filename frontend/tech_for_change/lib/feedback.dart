import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FeedForm(),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class FeedForm extends StatefulWidget {
  @override
  _FeedFormState createState() => _FeedFormState();
}

class _FeedFormState extends State<FeedForm> {

  Widget reportRow(String label, String data){
    return Container(
      padding: EdgeInsets.fromLTRB(13.0, 5.0, 10.0, 5.0),
      child : Row(
        children: <Widget>[
          Container(
            child: Text(label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0
            ),),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical : 15.0),
        child:  Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            reportRow("How to generate new report?", ""),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('1. Select New Recording card. \n2. Enter your personal details.\n3. Click the red button to start recording audio from \n    connected stethoscope.\n4. Stop recording when all the data has been collected.\n5. Submit the report for diagnosis.'),
                  )
                ],
              ),
            ),
            reportRow("How to view previous reports?", ""),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('1. Select View Reports card. \n2. Click on the arrow next to the report you want to view.\n3. Navigate through the report results.'),
                  )
                ],
              ),
            ),
            reportRow("How to update your profile?", ""),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('1. Select the edit(pencil) button. \n2. Edit your personal details.\n3. Click Save (Green Button) to save your changes.\n4. Click Cancel (Red Button) to discard your changes.'),
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}