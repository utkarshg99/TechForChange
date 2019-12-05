import 'package:flutter/material.dart';
import 'package:tech_for_change/dashboard.dart';
import 'package:tech_for_change/login_page.dart';
import 'package:tech_for_change/profile_page.dart';
import 'package:tech_for_change/register_page.dart';
import 'landing_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme){
        return MaterialApp(
          title: 'Tech For Change',
          routes: <String, WidgetBuilder>{
            '/' : (BuildContext context) => new LandingPage(),
            '/login' : (BuildContext context) => new LoginPage(),
            '/register' : (BuildContext context) => new RegPage(),
            '/dashboard' : (BuildContext context) => new Dashboard(),
            '/dashboard/profile' : (BuildContext context) => new ProfilePage(),
          },
          theme: theme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
