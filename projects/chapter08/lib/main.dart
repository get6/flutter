import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: BmiMain(),
    );
  }
}

// 첫번째 페이지(StatefulWidget)
class BmiMain extends StatefulWidget {
  @override
  _BmiMainState createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('[비만도 계산기]'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '키',
                  ),
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      // 입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return '키를 입력하세요';
                    }
                    return null; // null을 반환하면 에러가 없는 것임
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '몸무게',
                  ),
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "몸무게를 입력하세요";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: () {
                      // 폼에 입력한 값 검증
                      if (_formKey.currentState.validate()) {
                        // 키와 몸무게 값이 검증되었다면 화면 이동
                        // 검증시 처리
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BmiResult(
                              double.parse(_heightController.text.trim()),
                              double.parse(_weightController.text.trim()),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                    child: Text(
                      '결과',
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// 두번째 페이지(StatelessWidget)
class BmiResult extends StatelessWidget {
  final double height; // 키
  final double weight; // 몸무게

  BmiResult(this.height, this.weight); // 키와 모무게를 받는 생성자
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '비만도 계산기',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '정상',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Icon(
              Icons.sentiment_satisfied,
              color: Colors.green,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
