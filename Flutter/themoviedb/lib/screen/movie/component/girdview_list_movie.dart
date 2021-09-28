import 'package:flutter/material.dart';
import 'package:themoviedb/model/movie_tmdb.dart';
import 'package:themoviedb/screen/details_movie/movie_detail_screen.dart';

class GridViewListMovie extends StatelessWidget {
  const GridViewListMovie({
    Key? key,
    required ScrollController scrollController,
    required this.listMovie,
  }) : _scrollController = scrollController, super(key: key);

  final ScrollController _scrollController;
  final List<Result> listMovie;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.6),
      itemCount: listMovie.length,
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MovieDetailScreen.routeName,
                  arguments: MovieDetailsArguments(result: listMovie[position])
              );
            }
            ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Hero(
                    tag: listMovie[position].posterPath!,
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w500${listMovie[position].posterPath}',
                        width: 120,
                        height: 160,
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  listMovie[position].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'IMDb: ${listMovie[position].voteAverage}',
                  style:
                  TextStyle(fontSize: 12, color: Colors.black),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

