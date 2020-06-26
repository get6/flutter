import 'package:flutter/material.dart';
import 'package:padak/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      theme: ThemeData(
        primaryColor: Colors.cyan
      ),
      home: MainPage(),
    );
  }

}