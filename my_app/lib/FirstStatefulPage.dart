import 'package:flutter/material.dart';
import 'package:myapp/Person.dart';

import 'SecondStatefulPage.dart';

class FirstStatefulPage extends StatefulWidget {
  @override
  _FirstStatefulPageState createState() => _FirstStatefulPageState();
}

class _FirstStatefulPageState extends State<FirstStatefulPage> {

  @override
  Widget build(BuildContext context) {
    print('FirstPage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('First'),
      ),
      body: RaisedButton(
          child: const Text('다음 페이지로'),
          onPressed: () {
            final Person person = Person('홍길동', 20);
            Navigator.push<SecondStatefulPage>(
              context,
              MaterialPageRoute<SecondStatefulPage>(
                  builder: (BuildContext context) =>
                      SecondStatefulPage(person: person)),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    print('FirstPage initState()');
  }

  @override
  void dispose() {
    super.dispose();
    print('FirstPage dispose()');
  }
}
