import 'package:flutter/material.dart';

import 'package:padak/model/response/movies_response.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  MoviesResponse _moviesResponse;

  int _selectedTabIndex = 0;

  int _selectedSortIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('하이'),
        leading: Icon(Icons.menu),
        actions: <Widget>[_buildPopupMenuButton()],
      ),
      // body: _buildPage(_selectedTabIndex, _moviesResponse),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton(
      icon: Icon(Icons.sort),
      onSelected: _onSortMethodTab,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Text("예매율순"),
          ),
          PopupMenuItem(
            value: 0,
            child: Text("큐레이션"),
          ),
          PopupMenuItem(
            value: 0,
            child: Text("최신순"),
          ),
        ];
      },
    );
  }

  // 상단 우측 버튼 클릭 이벤트
  void _onSortMethodTab(index) {
    setState(() {
      _selectedSortIndex = index;
      switch (index) {
        case 0:
          print('예매율순');
          break;
        case 1:
          print('큐레이션');
          break;
        case 2:
          print('최신순');
          break;
      }
    });
  }
}
