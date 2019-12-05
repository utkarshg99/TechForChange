import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget RoundCard(double height, IconData icon, String text, String buttext, Color color){
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.deepPurple[450],
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
                color: Colors.black87,
              ),
              title: Text(
                text,
                style: TextStyle(
                  fontSize: 25.0,
                  // color: Colors.black
                ),
              ),
            ),
            ButtonTheme.bar(
              splashColor: color==Colors.deepPurple ? Colors.deepPurple[200] : Colors.white24,
              highlightColor: color==Colors.deepPurple ? Colors.deepPurple[200] : Colors.white24,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      buttext,
                      style: TextStyle(
                        color: color,
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0,),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.note_add, "New Recording", "New", Theme.of(context).primaryColor),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.view_list, "View Reports", "View", Theme.of(context).primaryColor),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.person_pin_circle, "Book Appointment", "Book", Theme.of(context).primaryColor),
            RoundCard((MediaQuery.of(context).size.height - 156.0)/4, Icons.chat, "Chat", "Open", Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}