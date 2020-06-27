import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/response/movie_response.dart';

// 3-1. 상세화면 - 라이브러리 임포트
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String movieId;

  DetailPage({this.movieId});

  @override
  State<StatefulWidget> createState() {
    return _DetailState(movieId: movieId);
  }
}

class _DetailState extends State<DetailPage> {
  String movieId;
  final String _movieTitle = '상세화면';
  MovieResponse _movieResponse;

  _DetailState({this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_movieTitle),
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    // 3-1. 상세화면 - 영화 상세 정보 데이터가 비었을 경우에 대한 분기 처리
    Widget contentsWidget;
    if (_movieResponse == null) {
      contentsWidget = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      contentsWidget = SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            _buildMovieSummary(),
            _buildMovieSynopsis(),
            _buildMovieCast(),
            _buildComment(),
          ],
        ),
      );
    }
    return contentsWidget;
  }

  Widget _buildMovieSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.network(
              _movieResponse.image,
              height: 180,
            ),
            const SizedBox(
              width: 10,
            ),
            _buildMovieSummaryTextColumn(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildReservationRate(),
            _buildVerticalDivider(),
            _buildUserRating(),
            _buildVerticalDivider(),
            _buildAudience(),
          ],
        )
      ],
    );
  }

  Widget _buildMovieSummaryTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _movieResponse.title,
          style: const TextStyle(fontSize: 22),
        ),
        Text(
          '${_movieResponse.date} 개봉',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${_movieResponse.genre} / ${_movieResponse.duration}분',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildReservationRate() {
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '예매율',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                '${_movieResponse.reservationGrade}위 ${_movieResponse.reservationRate.toString()}%'),
          ],
        )
      ],
    );
  }

  Widget _buildUserRating() {
    return Column(
      children: <Widget>[
        Text(
          '평점',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('${_movieResponse.userRating / 2}'),
      ],
    );
  }

  Widget _buildAudience() {
    final numberFormatter = NumberFormat.decimalPattern();
    return Column(
      children: <Widget>[
        Text(
          '누적관객수',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey,
    );
  }

  Widget _buildMovieSynopsis() {}

  Widget _buildMovieCast() {}

  Widget _buildComment() {}
}
