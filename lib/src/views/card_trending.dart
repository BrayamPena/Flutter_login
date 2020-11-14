import 'package:flutter/material.dart';
import 'package:flutter_login/src/models/trending.dart';

class CardTrending extends StatelessWidget {
  const CardTrending({Key key, this.trending}) : super(key: key);
  final Result trending;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            placeholder: AssetImage('assets/activity_indicator.gif'),
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${trending.backdropPath}'),
            fadeInDuration: Duration(milliseconds: 100),
          ),
        )
      ],
    );
  }
}
