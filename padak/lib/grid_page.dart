import 'package:flutter/material.dart';

import 'model/response/movies_response.dart';

class GridPage extends StatelessWidget {
  GridPage({this.movies});

  List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 9 / 16),
      itemBuilder: (BuildContext context, int index) =>
          _buildGridItem(context: context, index: index),
    );
  }

  Widget _buildGridItem({BuildContext context, @required int index}) {
    final Movie movie = movies[index];

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Image.network(
                    movie.thumb,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: _buildGradeImage(movie.grade),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FittedBox(
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                '${movie.reservationGrade}위(${movie.userRating} / ${movie.reservationRate}'),
            const SizedBox(
              height: 8,
            ),
            Text('${movie.date}'),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeImage(int grade) {
    switch (grade) {
      case 0:
        return Image.asset('assets/ic_allages.png');
      case 12:
        return Image.asset('assets/ic_12.png');
      case 15:
        return Image.asset('assets/ic_15.png');
      case 19:
        return Image.asset('assets/ic_19.png');
      default:
        return null;
    }
  }
}
