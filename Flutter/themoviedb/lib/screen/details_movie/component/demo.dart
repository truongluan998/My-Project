// class Body extends StatelessWidget {
//   const Body({
//     Key? key,
//     required this.movieRouteArguments,
//   }) : super(key: key);
//
//   final MovieDetailsArguments movieRouteArguments;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(5.0),
//       children: <Widget>[
//         Hero(
//           tag: movieRouteArguments.result.posterPath!,
//           child: Image.network(
//               'https://image.tmdb.org/t/p/w500${movieRouteArguments.result.posterPath}'),
//         ),
//         Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.all(10.0),
//           child: Text(
//             movieRouteArguments.result.title!,
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ),
//         Container(
//           alignment: Alignment.topRight,
//           margin: EdgeInsets.all(5.0),
//           child: Text('${movieRouteArguments.result.voteCount}'),
//         ),
//         Text(movieRouteArguments.result.overview!),
//       ],
//     );
//   }
// }
