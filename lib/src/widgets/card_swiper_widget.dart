import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/film_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Film> films;

  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          films[index].uniqueId = '${films[index].id}-card_swiper';
          return Hero(
            tag: films[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(films[index].getPosterImg()),
                    fit: BoxFit.fill,
                  ),
                  onTap: () => Navigator.pushNamed(context, 'detail',
                      arguments: films[index]),
                )),
          );
        },
        itemCount: films.length,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
