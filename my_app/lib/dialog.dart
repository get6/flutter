import 'package:flutter/material.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _showBS() {
      showModalBottomSheet<String>(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("What's your favorite pet?"),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Dog")),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cat")),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Ferret")),
            ],
          );
        },
      );
    }

    _showAD() {
      return showDialog<AlertDialog>(
        context: context,
        barrierDismissible: false,
        builder: (in2Context) {
          return AlertDialog(
            title: Text("We come in peace"),
            content: Center(
              child: Text("...shoot to kill shoot to kill shoot to kill"),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Beam me up, Scotty!"),
              )
            ],
          );
        },
      );
    }

    Future _showIt() async {
      switch (await showDialog<String>(
          context: context,
          builder: (inContext) {
            return SimpleDialog(
              title: Text("What's your favorite food?"),
              children: [
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(inContext, "brocolli"),
                  child: Text("brocolli"),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(inContext, "steak"),
                  child: Text("steak"),
                ),
              ],
            );
          })) {
        case "brocolli":
          print("Brocolli");
          break;
        case "steak":
          print("Steak");
          break;
      }
    }

    return Scaffold(
      key: GlobalKey(),
      body: Center(
        child: RaisedButton(
          onPressed: _showBS,
          child: Text("Show It"),
        ),
      ),
    );
  }
}
