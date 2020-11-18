import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/films_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_swiperCards(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: filmsProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(films: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            'Populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10.0,
          ),
          StreamBuilder(
            stream: filmsProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                    films: snapshot.data, nextPage: filmsProvider.getPopular);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
