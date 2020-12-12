import 'package:flutter_login/src/models/trending.dart';
import 'package:flutter/material.dart';

class CardFavorite extends StatelessWidget {
  const CardFavorite({Key key, this.favorite}) : super(key: key);
  final MovieFavorite favorite;

  @override
  Widget build(BuildContext context) {
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
                    'https://image.tmdb.org/t/p/w500/${favorite.backdropPath}'),
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
                    Text(favorite.title,
                        style: TextStyle(color: Colors.white, fontSize: 12.0)),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'id': favorite.idMovie,
                          'title': favorite.title,
                          'overview': favorite.overview,
                          'backdropPath': favorite.backdropPath,
                          'posterPath': favorite.posterPath,
                          'popularity': favorite.popularity,
                          'releaseDate': favorite.releaseDate,
                          'video': null,
                          'voteAverage': favorite.voteAverage
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
    );
  }
}
