import 'package:flutter/material.dart';

class StarRatingBar extends StatefulWidget {
  const StarRatingBar({
    this.size,
    this.rating,
    this.onRatingChanged,
    this.isUserInteractionEnabled = true,
  });

  final double size;
  final int rating;
  final void Function(int) onRatingChanged;
  final bool isUserInteractionEnabled;

  @override
  State<StatefulWidget> createState() {
    return _StarRatingBarState();
  }
}

class _StarRatingBarState extends State<StarRatingBar> {
  double _position = 0;
  bool _isDragStarted = false;

  int get _rating => _position ~/ (widget.size / 2);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isUserInteractionEnabled,
      child: GestureDetector(
        onHorizontalDragStart: (DragStartDetails startDetail) {
          _isDragStarted = true;
          final double leading = (MediaQuery.of(context).size.width - (widget.size * 5)) / 2 - 10;
          _position = startDetail.localPosition.dx - leading;
        },
        onHorizontalDragUpdate: (DragUpdateDetails updateDetail) {
          _position += updateDetail.delta.dx;
          if(_rating <= 0) {
            widget.onRatingChanged(0);
          } else if (_rating >= 10) {
            widget.onRatingChanged(10);
          } else {
            widget.onRatingChanged(_rating);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildStars(),
        ),
      ),
    );
  }

  List<Widget> _buildStars() {
    int value;
    if(!_isDragStarted) {
      value = widget.rating;
    } else {
      value = _rating;
    }
    final Icon emptyStar = Icon(Icons.star_border, size: widget.size,);
    final Icon halfStar = Icon(Icons.star_half, size: widget.size,);
    final Icon fullStar = Icon(Icons.star, size: widget.size,);
    List<Widget> stars = [
      emptyStar,
      emptyStar,
      emptyStar,
      emptyStar,
      emptyStar
    ];
    if (value == 0) {
      stars[0] = emptyStar;
    } else if (value == 1) {
      stars[0] = halfStar;
    } else if (value == 2) {
      stars[0] = fullStar;
      stars[1] = emptyStar;
    } else if (value == 3) {
      stars[0] = fullStar;
      stars[1] = halfStar;
    } else if (value == 4) {
      stars[0] = fullStar;
      stars[1] = fullStar;
    } else if (value == 5) {
      stars[0] = fullStar;
      stars[1] = fullStar;
      stars[2] = halfStar;
    } else if (value == 6) {
      stars[0] = fullStar;
      stars[1] = fullStar;
      stars[2] = fullStar;
    } else if (value == 7) {
      stars[0] = fullStar;
      stars[1] = fullStar;
      stars[2] = fullStar;
      stars[3] = halfStar;
    } else if (value == 8) {
      stars[0] = fullStar;
      stars[1] = fullStar;
      stars[2] = fullStar;
      stars[3] = fullStar;
    } else if (value == 9) {
      stars[0] = fullStar;
      stars[1] = fullStar;
      stars[2] = fullStar;
      stars[3] = fullStar;
      stars[4] = halfStar;
    } else if (value >= 10) {
      stars[0] = fullStar;
      stars[1] = fullStar;
      stars[2] = fullStar;
      stars[3] = fullStar;
      stars[4] = fullStar;
    }
    return stars;
  }
}
