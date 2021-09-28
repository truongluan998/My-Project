import 'package:flutter/material.dart';
import 'package:themoviedb/constants.dart';
import 'package:themoviedb/model/day_in_week.dart';
import 'package:themoviedb/model/ticket_movie.dart';
import 'package:themoviedb/screen/component/tag_movie.dart';
import 'package:themoviedb/screen/component/title_ticket.dart';
import 'package:themoviedb/size_config.dart';

import '../movie_detail_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.movieRouteArguments}) : super(key: key);

  final MovieDetailsArguments movieRouteArguments;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedDay = 0;
  int selectedHourSathyam = 0;
  int selectedHourEscape = 0;
  int selectedHourCineplex = 0;
  late final List<DayInWeek> dayInWeek;
  late final List<TicketMovie> ticketMovie;

  @override
  void initState() {
    super.initState();
    ticketMovie = fakeDataTicketMovie;
    dayInWeek = fakeDataDayInWeek;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildInfoMovie(context),
            SizedBox(height: SizeConfig.screenHeight * 0.04 ,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8)),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              dayInWeek.length, (index) => buildDayInWeek(index)),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04 ,),
                    showTicketSathyam('Sathyam Cinemas: Royapettah'),
                    SizedBox(height: SizeConfig.screenHeight * 0.03 ,),
                    showTicketCineplex('Escape Cinemas'),
                    SizedBox(height: SizeConfig.screenHeight * 0.03 ,),
                    showTicketEscape('Cineplex Movies',),
                    SizedBox(height: SizeConfig.screenHeight * 0.03 ,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column showTicketSathyam(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTicket(title: title),
        SizedBox(
          height: getProportionateScreenWidth(16),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                  ticketMovie.length, (index) => buildTicketSathyam(index))
            ],
          ),
        )
      ],
    );
  }

  Column showTicketCineplex(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTicket(title: title),
        SizedBox(
          height: getProportionateScreenWidth(16),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                  ticketMovie.length, (index) => buildTicketCineplex(index))
            ],
          ),
        )
      ],
    );
  }

  Column showTicketEscape(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTicket(title: title),
        SizedBox(
          height: getProportionateScreenWidth(16),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                  ticketMovie.length, (index) => buildTicketEscape(index))
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildTicketSathyam(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHourSathyam = index;
        });
      },
      child: buildTicket(index, selectedHourSathyam),
    );
  }

  GestureDetector buildTicketEscape(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHourEscape = index;
        });
      },
      child: buildTicket(index, selectedHourEscape),
    );
  }

  GestureDetector buildTicketCineplex(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHourCineplex = index;
        });
      },
      child: buildTicket(index, selectedHourCineplex),
    );
  }

  Padding buildTicket(int index, int selectedHour) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color:
                    selectedHour == index ? kPrimaryColor : kSecondaryColor)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(4),
              horizontal: getProportionateScreenWidth(28)),
          child: Text(
            ticketMovie[index].hour,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedHour == index
                    ? Colors.black
                    : kSecondaryColor.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  GestureDetector buildDayInWeek(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: getProportionateScreenWidth(60),
          height: getProportionateScreenWidth(72),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color:
                      selectedDay == index ? kPrimaryColor : kSecondaryColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayInWeek[index].day,
                style: TextStyle(
                    color: selectedDay == index
                        ? Colors.black
                        : kSecondaryColor.withOpacity(0.5)),
              ),
              Text(
                dayInWeek[index].date,
                style: TextStyle(
                    color: selectedDay == index
                        ? Colors.black
                        : kSecondaryColor.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Stack buildInfoMovie(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.4,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${widget.movieRouteArguments.result.posterPath}',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: SizeConfig.screenHeight * 0.4,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF343434).withOpacity(0.4),
                    Color(0xFF343434).withOpacity(0.15),
                  ])),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 52.0, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: getProportionateScreenWidth(32),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(24),
              ),
              buildCardOverview(),
            ],
          ),
        )
      ],
    );
  }

  Container buildCardOverview() {
    return Container(
      height: SizeConfig.screenHeight * 0.36,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    widget.movieRouteArguments.result.title!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCardHeaderOverview(Icons.star_outline_sharp,
                          '${widget.movieRouteArguments.result.voteAverage}'),
                      const SizedBox(
                        width: 20,
                      ),
                      buildCardHeaderOverview(Icons.timer, '${111}'),
                      const SizedBox(
                        width: 20,
                      ),
                      buildCardHeaderOverview(
                          Icons.qr_code,
                          getCountryCode(
                              '${widget.movieRouteArguments.result.originalLanguage}')),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(20),
                  ),
                  Divider(),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Synopsis',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          TagMovie(
                            title: 'Action',
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          TagMovie(title: 'Adventure')
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(8),
                  ),
                  Text(
                    '${widget.movieRouteArguments.result.overview}',
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: kSecondaryColor,
                    ),
                  )
                ],
              ),
              Container(
                width: getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.arrow_drop_down_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildCardHeaderOverview(IconData icon, String information) {
    return Container(
      child: Row(
        children: [
          Icon(icon, size: 16),
          SizedBox(
            width: 5,
          ),
          Text(
            information,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  String getCountryCode(String title) {
    return title.substring(title.length - 2);
  }
}

