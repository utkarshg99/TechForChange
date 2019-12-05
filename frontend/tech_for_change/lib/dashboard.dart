import "package:flutter/material.dart";
import 'package:tech_for_change/bottom_navy_bar.dart';
import 'package:tech_for_change/home_page.dart';
import 'package:tech_for_change/profile_page.dart';
import 'package:tech_for_change/settings_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => {
            setState(() => _currentIndex = index) 
          },
          children: <Widget>[
            Container(child: HomePage(),),
            Container(child: ProfilePage()),
            Container(child: SettingsPage(),),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text("Home"),
            icon : Icon(Icons.home),
            activeColor: Colors.redAccent,
          ),
          BottomNavyBarItem(
            title: Text("Profile"),
            icon : Icon(Icons.person),
            activeColor: Colors.deepOrangeAccent,
          ),
          BottomNavyBarItem(
            title: Text("Settings"),
            icon : Icon(Icons.settings),
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF8185E2),
//       bottomNavigationBar: BottomNavyBar(
//         //  selectedIndex: _selectedIndex,
//         showElevation: true, // use this to remove appBar's elevation
//         onItemSelected: (index) => () {} ,
//         items: [
//           BottomNavyBarItem(
//             icon: Icon(Icons.apps),
//             title: Text('Home'),
//             activeColor: Colors.red,
//           ),
//           BottomNavyBarItem(
//               icon: Icon(Icons.people),
//               title: Text('Profile'),
//               activeColor: Colors.purpleAccent
//           ),
//           BottomNavyBarItem(
//               icon: Icon(Icons.message),
//               title: Text('Messages'),
//               activeColor: Colors.pink
//           ),
//           BottomNavyBarItem(
//               icon: Icon(Icons.settings),
//               title: Text('Settings'),
//               activeColor: Colors.blue
//           ),
//         ],
//       )
//     );
//   }
// }