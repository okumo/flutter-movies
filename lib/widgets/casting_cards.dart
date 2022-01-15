import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  final int movieId;

  const CastingCard(this.movieId);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
                constraints: BoxConstraints(maxWidth: 150),
                height: 180,
                child: CupertinoActivityIndicator());
          }
          final List<Cast> cast = snapshot.data!;
          return Container(
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.only(bottom: 30),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast.length,
                itemBuilder: (_, int index) => _CastCard(cast[index])),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  _CastCard(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            '${actor.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ]));
  }
}
