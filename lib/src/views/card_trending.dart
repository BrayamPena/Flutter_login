import 'package:flutter/material.dart';
import 'package:flutter_login/src/models/trending.dart';

class CardTrending extends StatelessWidget {
  const CardTrending({Key key, this.trending}) : super(key: key);
  final Result trending;
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black87, offset: Offset(0.0, 5.0), blurRadius: 1.0)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${trending.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 100),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 55.0,
                color: Colors.black,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(trending.title,
                        style: TextStyle(color: Colors.white, fontSize: 12.0)),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'id': trending.id,
                          'title': trending.title,
                          'overview': trending.overview,
                          'backdropPath': trending.backdropPath,
                          'posterPath': trending.posterPath,
                          'popularity': trending.popularity,
                          'releaseDate': trending.releaseDate,
                          'video': trending.video,
                          'voteAverage': trending.voteAverage
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
=======
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
>>>>>>> origin/main
    );
  }
}
