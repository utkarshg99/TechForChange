import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget RoundCard(double height, IconData icon, String text, String buttext){
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.indigo[600],
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: Icon(
                icon,
                size: 60.0,
                color: Colors.black54,
              ),
              title: Text(
                text,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white
                ),
              ),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      buttext,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0
                      ),  
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Color(0xFF8185E2),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0,),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.note_add, "New Recording", "New"),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.view_list, "View Reports", "View"),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.person_pin_circle, "Book Appointment", "Book"),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.chat, "Chat", "Open"),
          ],
        ),
      ),
    );
  }
}