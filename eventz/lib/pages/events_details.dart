import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/mock_data.dart';
import 'package:eventz/backend/models.dart';
import 'package:eventz/pages/all_events_page.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:eventz/pages/my_web_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  final List members;

  const EventDetails({Key key, this.members, @required this.event})
      : super(key: key);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  MapController controller;
  bool isSaved = false;

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
    var unescape = HtmlUnescape();
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverAppBar(
              expandedHeight: 400,
              flexibleSpace: Hero(
                tag: widget.event.posterURL,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.event.posterURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0)
                .add(EdgeInsets.only(top: 120)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: ScaleAnimation(
                  child: Container(
                    margin: EdgeInsets.only(top: 260)
                        .add(EdgeInsets.symmetric(horizontal: 20.0)),
                    color: Theme.of(context).cardColor,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: TitleText(
                            unescape.convert(widget.event.title),
                            fontSize: 30,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubtitleText(
                                DateFormat('dd MMM, 22:00 - 04:00')
                                    .format(widget.event.date.toDate()),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              SubtitleText(widget.event.subtitle),
                            ],
                          ),
                          trailing: IconButton(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            icon: Icon(isSaved
                                ? FontAwesomeIcons.solidBookmark
                                : FontAwesomeIcons.bookmark),
                            onPressed: () {
                              setState(() {
                                isSaved = !isSaved;
                              });
                            },
                          ),
                        ),
                        Divider(
                          indent: 15,
                          thickness: 1.0,
                        ),
                        ListTile(
                          title: TitleText('About'),
                          subtitle: SubtitleText(
                              '${unescape.convert(widget.event.description)}'),
                        ),
                        Divider(
                          indent: 15,
                          thickness: 1.0,
                        ),
                        ListTile(
                          title: SubtitleText('Price per ticket:'),
                          trailing: TitleText(
                            '\$ ${widget.event.ticketPrice}',
                            color: Theme.of(context).primaryColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Divider(
                          indent: 15,
                          thickness: 1.0,
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleText('Map'),
                              IconButton(
                                  onPressed: () {
                                    // MapsLauncher.launchCoordinates(
                                    //     37.4220041, -122.0862462);
                                  },
                                  icon: Icon(FontAwesomeIcons.locationArrow))
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: 200,
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
                        Divider(
                          indent: 15,
                          thickness: 1.0,
                        ),
                        ListTile(
                          title: TitleText('More Events'),
                        ),
                        Column(
                          children: List.generate(
                              events.length > 5 ? 5 : events.length, (index) {
                            Event event = Event.fromMap(events[index]);
                            if (event.title == widget.event.title)
                              return Container();
                            return FadeAnimation(
                              0.2,
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: EventsBox(
                                  event: event,
                                  isTile: true,
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ScaleAnimation(
        child: Container(
          height: 80,
          child: Container(
            height: 80,
            color: Theme.of(context).primaryColor,
            child: AwesomeButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: TitleText('Buy Tickets'),
                              ),
                              body: MyWebView(
                                title: 'Buy Tickets',
                                url: widget.event.listingUrl,
                              ),
                            )));
              },
              child: TitleText(
                'BOOK',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
