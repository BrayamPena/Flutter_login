import 'package:flutter/material.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/cast.dart';
import 'package:flutter_login/src/models/trending.dart';
import 'package:flutter_login/src/models/videoTrailer.dart';
import 'package:flutter_login/src/network/api_movies.dart';
import 'dart:ui';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiMovies apiMovies = ApiMovies();
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    List<CastElement> movieCast;
    List<Resultv> movieVid;
    YoutubePlayerController _controller;
    IconData icon = Icons.favorite_outline;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie: ${movie['title']}'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              _guardarEliminarFavoritos(movie);
            },
            child: Icon(icon, color: Colors.black),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        //imagen de fondo con blur
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500/${movie['posterPath']}',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              )),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(30.0),
              //column del poster
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 400,
                      height: 400,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500/${movie['posterPath']}'),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              offset: Offset(0.0, 10.0))
                        ]),
                  ),
                  //Container del titulo y average
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                    //Row del titulo y vote average
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          '${movie['title']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'Arvo'),
                        )),
                        Text(
                          '${movie['voteAverage']}/10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Arvo'),
                        )
                      ],
                    ),
                  ),
                  //Text de la descripccion
                  Text('${movie['overview']}',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  //Obtencion del cast
                  FutureBuilder(
                    future: apiMovies.getCast('${movie['id']}'),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CastElement>> snapshot) {
                      if (snapshot.hasError) {
                        //print(snapshot.error);
                        return Center(
                            child: Text('Has error in this request :('));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        movieCast = snapshot.data;
                        return Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.people, color: Colors.white),
                                Text('  Cast',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Arvo',
                                        fontSize: 20)),
                                Padding(padding: const EdgeInsets.all(10.0)),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              // Horizontal ListView
                              height: 100,
                              child: ListView.builder(
                                itemCount: movieCast.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            movieCast[index].profilePath != null
                                                ? CircleAvatar(
                                                    radius: 30.0,
                                                    backgroundImage: NetworkImage(
                                                        'https://image.tmdb.org/t/p/w500/${movieCast[index].profilePath}'),
                                                  )
                                                : CircleAvatar(
                                                    radius: 30.0,
                                                    backgroundImage: NetworkImage(
                                                        'https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png'),
                                                  )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(movieCast[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Arvo',
                                                      fontSize: 10)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ), //fin cast
                  //Para el video de youtube
                  Row(
                    children: [
                      Icon(Icons.video_label, color: Colors.white),
                      Text('  Trailer',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arvo',
                              fontSize: 20)),
                      Padding(padding: const EdgeInsets.all(10.0)),
                    ],
                  ),
                  SizedBox(height: 10),
                  //Obtener el video
                  FutureBuilder(
                    future: apiMovies.getVideo("${movie['id']}"),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Resultv>> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Has error in this request :('));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        movieVid = snapshot.data;
                        //Controller youtube palyer
                        _controller = YoutubePlayerController(
                          initialVideoId: movieVid[0].key,
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        );
                        return SingleChildScrollView(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                    controller: _controller,
                                    aspectRatio: 16 / 9,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.red,
                                  ),
                                  builder: (context, player) {
                                    return Column(
                                      children: <Widget>[player],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  /*Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                        onPressed: () {
                          _launchUrl('${movie['video']}');
                        },
                        child: Container(
                          width: 150.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          child: Text(
                            'Ver Trailer',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Arvo',
                                fontSize: 20.0),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        ),
                      )),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF6200EE),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
          switch (value) {
            case 0:
              print('Aqui se mandaria a guardar');
              _guardarEliminarFavoritos(movie);
              break;
            case 1:
              _verFavoritos(movie);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Favorite'),
            icon: Icon(Icons.favorite_border), //favorite_sharp
          ),
          BottomNavigationBarItem(
            title: Text('News'),
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
    );
  }

  /*void _launchUrl(String vid) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  //Metodo para guardar la pelicula favorita
  void _guardarEliminarFavoritos(Map<String, dynamic> movie) async {
    DataBaseHelper _database = DataBaseHelper();
    MovieFavorite movieFav = MovieFavorite(
        id: int.parse("${movie['id']}"),
        idMovie: "${movie['idMovie']}",
        title: "${movie['title']}",
        overview: "${movie['overview']}",
        backdropPath: "${movie['backdropPath']}",
        posterPath: "${movie['posterPath']}",
        popularity: double.parse("${movie['popularity']}"),
        releaseDate: "${movie['releaseDate']}",
        voteAverage: double.parse("${movie['voteAverage']}"));
    var verificar = await _database.getMovie(int.parse("${movie['id']}"));
    print(movieFav);
    if (verificar == null) {
      _database.insertar(movieFav.movieToJSON(), 'tbl_favoritos');
      Fluttertoast.showToast(
        msg: "Ya se guardo compa",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      _database.eliminar(verificar.id, 'tbl_favoritos');
      Fluttertoast.showToast(
        msg: "Ya se elimino compa :C",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void _verFavoritos(Map<String, dynamic> movie) async {
    DataBaseHelper _database = DataBaseHelper();
    //Future<List<MovieFavorite>> favoritemovies;
    var favoritemovies = await _database.getFavorites();
    print(movie);
  }
}
