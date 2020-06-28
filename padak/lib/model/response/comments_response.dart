class CommentsResponse {
  CommentsResponse(this.movieId, this.comments);

  // map 구조에서 새로운 CommentsResponse 객체를 생성
  CommentsResponse.fromJson(dynamic json) {
    movieId = json['movie_id'] as String;
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((dynamic comment) {
        comments.add(Comment.fromJson(comment));
      });
    }
  }

  String movieId;
  List<Comment> comments;
}

class Comment {
  Comment(
      {this.rating,
      this.id,
      this.timestamp,
      this.writer,
      this.contents,
      this.movieId});

  Comment.fromJson(dynamic json) {
    rating = json['rating'] as int;
    id = json['id'] as String;
    timestamp = json['timestamp'] as int;
    writer = json['writer'] as String;
    contents = json['contents'] as String;
    movieId = json['movie_id'] as String;
  }

  // 평점 (1 ~ 10)
  int rating;

  // 한줄평 고유 ID
  String id;

  // 작성일시 UnixStamp 값
  int timestamp;

  // 작성자
  String writer;

  // 한줄평 내용
  String contents;

  // 영화 고유 ID
  String movieId;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['rating'] = rating;
    map['id'] = id;
    map['timestamp'] = timestamp;
    map['writer'] = writer;
    map['contents'] = contents;
    map['movie_id'] = movieId;
    return map;
  }
}
