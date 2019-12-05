import 'dart:async';

import "package:flutter/material.dart";
import 'package:tech_for_change/auth_state.dart';
import 'package:tech_for_change/bottom_navy_bar.dart';
import 'package:tech_for_change/home_page.dart';
import 'package:tech_for_change/profile_page.dart';
import 'package:tech_for_change/settings_page.dart';

class Dashboard extends StatefulWidget {

  final StreamController<AuthenticationState> _streamController;

  Dashboard(this._streamController);

  @override
  _DashboardState createState() => _DashboardState(_streamController);
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  PageController _pageController;

  StreamController<AuthenticationState> _streamController;

  _DashboardState(this._streamController);

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
            Container(child: SettingsPage(_streamController),),
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