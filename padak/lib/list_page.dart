import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'model/response/movies_response.dart';

class ListPage extends StatelessWidget {
  List<Movie> movies;

  ListPage({this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, int index) => Divider(
        color: Colors.grey,
      ),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: _buildItem(movies[index]),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                  builder: (_) => DetailPage(movieId: movies[index].id)),
            );
          },
        );
      },
    );
  }

  Widget _buildItem(Movie movie) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            movie.thumb,
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    _buildGradeImage(movie.grade),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('평점 : ${movie.userRating / 2}'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('예매순위 : ${movie.reservationGrade}'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('예매율 : ${movie.reservationRate}'),
                  ],
                )
              ],
            ),
          ),
        ],
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
