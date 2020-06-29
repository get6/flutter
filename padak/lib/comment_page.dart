import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:padak/model/response/comments_response.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  const CommentPage({this.movieTitle, this.movieId});

  final String movieTitle;
  final String movieId;

  @override
  State<StatefulWidget> createState() {
    return CommentPageState(movieTitle: movieTitle, movieId: movieId);
  }
}

class CommentPageState extends State<CommentPage> {
  CommentPageState({this.movieTitle, this.movieId});

  String movieTitle;
  String movieId;

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  int _rating = 0;
  String _writer = "";
  String _contents = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: const Text('한줄평 작성'),
        actions: <Widget>[
          _buildSubmitButton(),
        ],
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildMovieTitle(),
                _buildUserRating(),
                _buildHorizontalDivider(),
                _buildNickNameInputForm(),
                _buildCommentInputForm()
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    final Icon sendIcon = Icon(
      Icons.send,
      color: Colors.white,
      size: 25,
    );

    return IconButton(
        icon: sendIcon,
        onPressed: () {
          if (_writer.isEmpty || _contents.isEmpty) {
            _showSnackBar('모든 정보를 입력해주세요.');
          } else {
            // 4-1. 한줄평 입력 - 서버 통신 로직 진행
            _postComment();
          }
        });
  }

  // 4-1. 한줄평 입력 - Post 요청 코드 작성
  void _postComment() async {
    // (Datetime.now().millsecondsSinceEposh.toDouble() / 1000).toInt() 와 같은 말입니다.
    final int currentTime =
        DateTime
            .now()
            .millisecondsSinceEpoch
            .toDouble() ~/ 1000;
    final Comment commentRequest = Comment(
      rating: _rating,
      movieId: widget.movieId,
      timestamp: currentTime,
      contents: _contents,
      writer: _writer,
    );
    final http.Response response = await http.post(
        'http://padakpadak.run.goorm.io/comment',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(commentRequest.toMap()));
    if (response.statusCode == 200) {
      Navigator.of(context).pop(true);
    } else {
      _showSnackBar('잠시 후 다시 시도해주세요');
    }
  }

  Widget _buildMovieTitle() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        widget.movieTitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUserRating() {}

  Widget _buildHorizontalDivider() {}

  Widget _buildNickNameInputForm() {}

  Widget _buildCommentInputForm() {}

  void _showSnackBar(String text) {
    final SnackBar snackBar = SnackBar(
      content: Text(text),
    );
    scaffoldState.currentState.showSnackBar(snackBar);
  }
}
