
class MoviesResponse {
  int orderType;
  List<Movie> movies;

  MoviesResponse({
    this.orderType,
    this.movies,
  });

  // map 구조에서 새로운 MoviesResponse 객체를 생성
  MoviesResponse.fromJson(dynamic json) {
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((dynamic movie) {
        movies.add(Movie.fromJson(movie));
      });
    }
    orderType = json['order_type'] as int;
  }
}

class Movie {
  String title;
  int userRating;
  int grade;
  int reservationGrade;
  String id;
  String date;
  String thumb;
  double reservationRate;

  Movie({this.title,
    this.userRating,
    this.grade,
    this.reservationGrade,
    this.id,
    this.date,
    this.thumb,
    this.reservationRate});

  Movie.fromJson(dynamic json) {
    title = json['title'] as String;
    userRating = json['user_rating'] as int;
    grade = json['grade'] as int;
    reservationGrade = json['reservation_grade'] as int;
    id = json['id'] as String;
    date = json['date'] as String;
    thumb = json['thumb'] as String;
    reservationRate = json['reservation_rate'] as double;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['user_rating'] = userRating;
    map['grade'] = grade;
    map['reservation_grade'] = reservationGrade;
    map['id'] = id;
    map['date'] = date;
    map['thumb'] = thumb;
    map['reservation_rate'] = reservationRate;
    return map;
  }
}
