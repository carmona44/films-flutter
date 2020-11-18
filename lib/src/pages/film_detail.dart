import 'package:flutter/material.dart';
import 'package:peliculas/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(film),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _titlePoster(context, film),
            _description(film),
          ]))
        ],
      ),
    );
  }

  Widget _createAppBar(Film film) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(film.title,
              style: TextStyle(color: Colors.white, fontSize: 14.0)),
          background: FadeInImage(
            image: NetworkImage(film.getBackgroundDetailImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _titlePoster(BuildContext context, Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(film.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                film.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                film.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(film.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(Film film) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(film.overview, textAlign: TextAlign.justify),
    );
  }
}
