import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

  }

}