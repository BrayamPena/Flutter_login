import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/src/models/trending.dart';
import 'package:flutter_login/src/network/api_movies.dart';
import 'package:flutter_login/src/views/card_trending.dart';

class Trending extends StatefulWidget {
  const Trending({Key key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  ApiMovies apiMovies;
  @override
  @override
  void initState() {
    super.initState();
    apiMovies = ApiMovies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies: '),
      ),
      body: FutureBuilder(
        future: apiMovies.getTrending(),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Has error in this request :('));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _listTrending(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _listTrending(List<Result> movies) {
    return (ListView.builder(
      itemBuilder: (context, index) {
        Result trending = movies[index];
        return CardTrending(trending: trending);
      },
      itemCount: 20,
    ));
  }
}
