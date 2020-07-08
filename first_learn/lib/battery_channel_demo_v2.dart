import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BatteryPage());

class BatteryPage extends StatefulWidget {
  @override
  State createState() => BatteryPageState();
}

class BatteryPageState extends State<BatteryPage> {
  String _text = '배터리 잔량: 모름';

  static const String CHANNEL_BATTERY = 'android/battery';
  static const String METHOD_BATTERY = 'getBatteryLevel';
  static const MethodChannel batteryChannel = MethodChannel(CHANNEL_BATTERY);

  _refresh() async {
    print('refresh battery level');

    String _newText;
    try {
      final int result = await batteryChannel.invokeListMethod(METHOD_BATTERY) as int;
      _newText = '배터리 잔량: $result';
    } on PlatformException {
      _newText = '배터리 잔량을 알 수 없습니다.';
    } catch (e) {
      _newText = '배터리 잔량을 알 수 없습니다.';
      print(e);
    }

    setState(() {
      _text = _newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배터리 채널 데모 V2',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('배터리 채널 데모 V2'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('배터리 잔량: 모름'),
              RaisedButton(
                onPressed: _refresh,
                child: Text('가져오기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
