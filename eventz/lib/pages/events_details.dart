import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/events_home_page.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class FullEventsPage extends StatefulWidget {
  final String posterUrl, title, subtitle;

  const FullEventsPage(
      {Key key,
      @required this.posterUrl,
      @required this.title,
      @required this.subtitle})
      : super(key: key);
  @override
  _FullEventsPageState createState() => _FullEventsPageState();
}

class _FullEventsPageState extends State<FullEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(
      //       FontAwesomeIcons.chevronLeft,
      //       color: Theme.of(context).textTheme.bodyText1.color,
      //     ),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            brightness: Brightness.dark,
            centerTitle: true,
            flexibleSpace: Stack(
              children: [
                Hero(
                  tag: widget.posterUrl,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(widget.posterUrl),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 200,
                child: FadeAnimation(
                  0.1,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              widget.title,
                              fontSize: 24,
                              // color: Colors.white,
                            ),
                            SubtitleText(
                              widget.subtitle,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: ScaleAnimation(
                          child: Image.asset(GlobalValues.findImage),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              color: Theme.of(context).accentColor,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0, left: 10.0),
              child: Scrollbar(
                radius: Radius.circular(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeAnimation(
                        0.3,
                        EventTile.verticle(
                          imageURL: 'images/posters/nano.jpeg',
                          title: 'DJ Nano',
                          subtitle: 'Village Roadhouse',
                          creator: 'V5',
                          distance: '0.8',
                          date: DateTime(2021, 2, 27),
                          description:
                              'Tonight is going to be an awesome night. Get ready to rock your world.',
                          ticketPrice: '18.4',
                        ),
                      ),
                      FadeAnimation(
                        0.4,
                        EventTile.verticle(
                          imageURL: 'images/posters/baila.jpeg',
                          title: 'DJ JStar',
                          subtitle: 'Baila Fridays ',
                          creator: 'V5',
                          distance: '1.2',
                          date: DateTime(2021, 9, 18),
                          description:
                              'Tonight is going to be an awesome night. Get ready to rock your world.',
                          ticketPrice: '22.6',
                        ),
                      ),
                      FadeAnimation(
                        0.4,
                        EventTile.verticle(
                          imageURL: 'images/posters/luxur.jpeg',
                          title: 'DJ Ozone',
                          subtitle: 'Luxur Saturdays',
                          creator: 'V5',
                          distance: '2.4',
                          date: DateTime(2021, 9, 22),
                          description:
                              'Tonight is going to be an awesome night. Get ready to rock your world.',
                          ticketPrice: '18.2',
                        ),
                      ),
                      FadeAnimation(
                        0.5,
                        EventTile.verticle(
                          imageURL: 'images/posters/brunch.jpeg',
                          title: 'Brunch : This saturday',
                          subtitle: 'V5 DJs',
                          creator: 'V5',
                          distance: '0.4',
                          date: DateTime(2021, 7, 13),
                          description:
                              'Tonight is going to be an awesome night. Get ready to rock your world.',
                          ticketPrice: '16.1',
                        ),
                      ),
                      FadeAnimation(
                        0.6,
                        EventTile.verticle(
                          imageURL: 'images/posters/joy.jpeg',
                          title: 'Parley',
                          subtitle: 'JOY District',
                          creator: 'V5',
                          distance: '1.8',
                          date: DateTime(2021, 2, 3),
                          description:
                              'Tonight is going to be an awesome night. Get ready to rock your world.',
                          ticketPrice: '12.4',
                        ),
                      ),
                      FadeAnimation(
                        0.7,
                        EventTile.verticle(
                          imageURL: 'images/posters/verde.jpeg',
                          title: 'Verde',
                          subtitle: 'JOY District',
                          creator: 'V5',
                          distance: '1.8',
                          date: DateTime(2021, 3, 22),
                          description:
                              'Tonight is going to be an awesome night. Get ready to rock your world.',
                          ticketPrice: '32.5',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EventDetails extends StatefulWidget {
  final String title,
      subtitle,
      description,
      distance,
      imageURL,
      creator,
      ticketPrice;
  final List members;
  final DateTime date;

  const EventDetails(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.distance,
      @required this.imageURL,
      @required this.creator,
      @required this.date,
      this.members,
      this.ticketPrice,
      @required this.subtitle})
      : super(key: key);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  MapController controller;
  bool isOpened = true;

  void _gotoDefault() {
    controller.center = LatLng(35.68, 51.41);
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
  }

  Offset _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = MapController(
      location: LatLng(35.68, 51.41),
    );
    _gotoDefault();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpened = !isOpened;
              });
            },
            child: Hero(
              tag: widget.imageURL,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imageURL),
                      fit: isOpened ? BoxFit.cover : BoxFit.contain,
                    ),
                  ),
                  child: Container(
                    color: isOpened
                        ? Colors.black.withOpacity(0.4)
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          !isOpened
              ? SizedBox.shrink()
              : ScaleAnimation(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.all(10.0).add(
                        EdgeInsets.only(top: 25.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Container(
                                padding: EdgeInsets.all(
                                  8.0,
                                ).add(
                                  EdgeInsets.only(right: 2.0, bottom: 2.0),
                                ),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Icon(FontAwesomeIcons.chevronLeft)),
                            onPressed: () => Navigator.pop(context),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Icon(FontAwesomeIcons.share)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          !isOpened
              ? SizedBox.shrink()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScaleAnimation(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2),
                                )
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleText(widget.title),
                                    SubtitleText(
                                      '${widget.subtitle}',
                                      fontSize: 16,
                                    ),
                                    SubtitleText(
                                      DateFormat('EEEE MMM, d')
                                          .format(widget.date),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey,
                                height: 50.0,
                                width: 1.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0).add(
                                  EdgeInsets.only(left: 10.0),
                                ),
                                child: TitleText(
                                  '\$ ${widget.ticketPrice}',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ScaleAnimation(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText('Event Description'),
                              SubtitleText('${widget.description}'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 18,
                                              ),
                                              SubtitleText(' Directions',
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ],
                                          ),
                                        ),
                                        SubtitleText(
                                          '${widget.distance} miles away',
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.clock,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 18,
                                              ),
                                              SubtitleText(' Doors',
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ],
                                          ),
                                        ),
                                        SubtitleText(
                                          '10pm-4am',
                                          fontSize: 18,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.parking,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 18,
                                              ),
                                              SubtitleText(' Parking',
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ],
                                          ),
                                        ),
                                        SubtitleText(
                                          'Free',
                                          fontSize: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ScaleAnimation(
                        child: Container(
                          height: 120,
                          // padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2),
                                )
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: GestureDetector(
                              onDoubleTap: _onDoubleTap,
                              onScaleStart: _onScaleStart,
                              onScaleUpdate: _onScaleUpdate,
                              onScaleEnd: (details) {
                                print(
                                    "Location: ${controller.center.latitude}, ${controller.center.longitude}");
                              },
                              child: Map(
                                controller: controller,
                                builder: (context, x, y, z) {
                                  final url =
                                      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                                  return CachedNetworkImage(
                                    imageUrl: url,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
