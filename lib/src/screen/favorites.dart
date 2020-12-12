import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/trending.dart';
import 'package:flutter_login/src/views/card_favorites.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  DataBaseHelper _database = DataBaseHelper();
  //var favoritemovies = await _database.getFavorites();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies: '),
      ),
      body: FutureBuilder(
        future: _database.getFavorites(),
        builder: (BuildContext context,
            AsyncSnapshot<List<MovieFavorite>> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            if (snapshot.data == null)
              return Center(child: Text('No has agregado favoritos :('));
            else
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

  Widget _listTrending(List<MovieFavorite> movies) {
    return (ListView.builder(
      itemBuilder: (context, index) {
        MovieFavorite favorite = movies[index];
        return CardFavorite(favorite: favorite);
      },
      itemCount: movies.length,
    ));
  }
=======

class Favorites extends StatelessWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Favorites'),
    );
  }
>>>>>>> origin/main
}
