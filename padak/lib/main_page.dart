import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:padak/model/response/movies_response.dart';
import 'package:http/http.dart' as http;
import 'grid_page.dart';
import 'list_page.dart';
import 'model/response/movies_response.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  // 2-1. 메인화면 - 서버로부터 받아올 영화 목록 데이터 변수 선언
  MoviesResponse _moviesResponse;

  int _selectedTabIndex = 0;

  // 2-1. 메인화면 - 선택한 sort 방식에 대한 변수 선언
  int _selectedSortIndex = 0;

  // 2-2. 메인화면 - initState() 에서 영화 목록을 가져옵니다.
  @override
  void initState() {
    super.initState();
    _requestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 2-4. 메인화면 - title 수정
        title: Text(_getMenuTitleBySortIndex(_selectedSortIndex)),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          // 2-4 메인화면 - 팝업 메뉴 호출 함수화 (호출)
          _buildPopupMenuButton()
        ],
      ),
      // 2-2. 메인화면 - _buildPage() 로직 전면 수정
      body: _buildPage(_selectedTabIndex, _moviesResponse),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), title: const Text('List')),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_on), title: const Text('Grid')),
        ],
        currentIndex: _selectedTabIndex,
        onTap: (int index) {
          setState(() {
            _selectedTabIndex = index;
            print('$_selectedTabIndex Tab Clicked');
          });
        },
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton<int>(
      icon: Icon(Icons.sort),
      onSelected: _onSortMethodTab,
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text('예매율순'),
          ),
          const PopupMenuItem<int>(
            value: 0,
            child: Text('큐레이션'),
          ),
          const PopupMenuItem<int>(
            value: 0,
            child: Text('최신순'),
          ),
        ];
      },
    );
  }

  // 2.4 메인화면 - 클릭 시 실행될 로직 작성
  void _onSortMethodTab(int index) {
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
    _requestMovies();
  }

  // 2-1. 메인화면 - MovieResponse 데이터 받아오기
  void _requestMovies() async {
    // 1. 영화 목록 데이터 초기화
    setState(() {
      _moviesResponse = null;
    });
    // 2. 서버에 요청을 진행하여 응답 데이터를 가져옴
    final http.Response response = await http.get(
        'http://padakpadak.run.goorm.io/movies?order_type=$_selectedSortIndex');
    if (response.statusCode == 200) {
      final dynamic jsonData =
          json.decode(response.body);
      final MoviesResponse moviesResponse = MoviesResponse.fromJson(jsonData);
      setState(() {
        _moviesResponse = moviesResponse;
      });
    }
  }

  // 2-4 메인화면 - 각 index에 맞는 제목을 호출해주는 로직 작성
  String _getMenuTitleBySortIndex(int index) {
    switch (index) {
      case 0:
        return '예매율';
      case 1:
        return '큐레이션';
      case 2:
        return '최신순';
      default:
        return '';
    }
  }

  // 2-2 메인화면 - _buildPage() 함수 내용 수정
  Widget _buildPage(int index, MoviesResponse moviesResponse) {
    Widget contentsWidget;

    // 2-3. 메인화면 - moviesResponse가 비었을 경우에 대한 분기 처리
    if (moviesResponse == null) {
      contentsWidget = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      switch (index) {
        case 0:
          contentsWidget = ListPage(movies: moviesResponse.movies);
          break;
        case 1:
          contentsWidget = GridPage(movies: moviesResponse.movies);
          break;
        default:
          contentsWidget = Container();
      }
    }
    return contentsWidget;
  }
}
