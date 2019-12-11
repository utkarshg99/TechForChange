import 'package:flutter/material.dart';
import 'package:tech_for_change/report_full.dart';

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

  Widget makeListTile(String date){
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportFull()),
          );
        },
      )
    );
  }

  Widget makeCard() {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Container(
        child: makeListTile("date"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return makeCard();
        },
      ),
    );
  }
}