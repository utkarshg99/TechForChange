import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_for_change/report_full.dart';
import 'package:http/http.dart' as http;
import 'package:tech_for_change/url.dart';
import 'dart:convert';
import './report_data.dart';

class ViewReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
        title: Text("View Reports"),
      ),
      body: ViewReportList(),
    );
  }
}

class ViewReportList extends StatefulWidget {
  @override
  _ViewReportListState createState() => _ViewReportListState();
}

class _ViewReportListState extends State<ViewReportList> {

  String _email;
  bool _status = false;
  List<dynamic> fullReportData;

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('uid');

    var response = await http.post(
      Uri.encodeFull(url + '/getReport'),
      headers: {
        'Content-Type' : 'application/json'
      },
      body: json.encode({'uid' : _email}),
    );
    Map data = json.decode(response.body);
    // print(data);
    _status = data['status'];
    if(_status){
      setState(() {
        fullReportData = data['data'];
      });
    }
    print(fullReportData);
  }

  Widget makeListTile(String date, int index){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
          right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(
          Icons.note ,
          size: 50.0,
        ),
      ),
      title: Text(
        "Report",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(date),
      trailing: IconButton(
        icon: Icon(
          Icons.navigate_next,
          color: Colors.white,
          size: 35.0,
        ),
        onPressed: () {
          // print(fullReportData[index]);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportFull(data: fullReportData[index],)),
          );
        },
      )
    );
  }

  Widget makeCard(int index) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Container(
        child: makeListTile(fullReportData[index]['date'].toString().split(' ')[0], index),
      ),
    );
  }

  @override
  initState(){
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // print(fullReportData.length);
    Widget child;
    if(_status==false){
      child = Center(
        child: Container(
          child: Text(
            "No reports available",
            style: TextStyle(
              fontSize: 30.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    else{
      child = Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: fullReportData.length,
          itemBuilder: (BuildContext context, int index) {
            // print(index);
            return makeCard(index);
          },
        ),
      );
    }
    return child;
  }
}