import 'package:flutter/material.dart';
import 'package:myapp/FirstStatefulPage.dart';

import 'SecondStatefulPage.dart';

void main() {
  runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstStatefulPage(),
      routes: {
        '/first' : (BuildContext context) => FirstStatefulPage(),
        '/second' : (BuildContext context) => const SecondStatefulPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = 'Hello';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
      ),
      body: Text(
        _text,
        style: const TextStyle(
          fontSize: 40,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _text = 'World';
          });
        },
        child: Icon(Icons.touch_app),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
