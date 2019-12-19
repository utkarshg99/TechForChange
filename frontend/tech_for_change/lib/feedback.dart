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
    return Center(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            reportRow('Generate New Report', ''),
            reportRow('View Previous Reports', ''),
            reportRow('Update Profile', ''),     
          ],
        ),
      ),
    );
  }
}