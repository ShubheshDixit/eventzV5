import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/dynamic_link_service.dart';
import 'package:eventz/backend/models.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:eventz/pages/my_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:markdown_widget/config/style_config.dart';
import 'package:markdown_widget/markdown_generator.dart';

class EventDetails extends StatefulWidget {
  final String eventId;
  const EventDetails({Key key, @required this.eventId}) : super(key: key);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  MapController controller;
  bool isSaved = false;
  Event event;

  void _gotoDefault() {
    controller.center =
        LatLng(controller.center.latitude, controller.center.longitude);
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

  Widget _buildMarkerWidget(Offset pos, Color color) {
    return Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 24,
      height: 24,
      child: Icon(Icons.location_on, color: color),
    );
  }

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  getEvent() async {
    final doc = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .get();
    setState(() {
      event = Event.fromDoc(doc);
    });
    controller = MapController(
      location: LatLng(event.lat, event.lng),
    );
    _gotoDefault();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> launchMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first
        .showMarker(coords: Coords(event.lat, event.lng), title: event.venue);
  }

  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return Scaffold(
      body: event == null
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitChasingDots(
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            )
          : Stack(
              children: [
                CustomScrollView(slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    flexibleSpace: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(event.bannerUrl != null &&
                                  event.bannerUrl.length > 0
                              ? event.bannerUrl
                              : 'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/06/mansiontopcontent.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        color: Colors.pink[900].withOpacity(0.5),
                        child: Center(
                          child: Container(
                            // height: 100,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[900],
                              border: Border(
                                  top:
                                      BorderSide(color: Colors.white, width: 2),
                                  bottom: BorderSide(
                                      color: Colors.white, width: 2)),
                            ),
                            child: TitleText(
                              unescape.convert(event.title),
                              textAlign: TextAlign.center,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0)
                      .add(EdgeInsets.only(top: 100)),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: ScaleAnimation(
                        child: Container(
                          margin: EdgeInsets.only(top: 180)
                              .add(EdgeInsets.symmetric(horizontal: 10.0)),
                          color: Theme.of(context).cardColor,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleText(
                                      unescape.convert(event.title),
                                      textAlign: TextAlign.left,
                                      fontSize: 30,
                                    ),
                                  ],
                                ),
                              ),

                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),

                              // Event Poster
                              Center(
                                child: Hero(
                                  transitionOnUserGestures: true,
                                  tag: event.id,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      width: 250,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        image: DecorationImage(
                                          image: NetworkImage(event.imageUrl),
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

                              // Url Action buttons
                              Container(
                                // height: 200,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5),
                                child: Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    event.showUrl != null &&
                                            event.showUrl.length > 10
                                        ? AwesomeButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Scaffold(
                                                            appBar: AppBar(
                                                              title: TitleText(
                                                                  'Buy Tickets'),
                                                            ),
                                                            body: MyWebView(
                                                              title:
                                                                  'Buy Tickets',
                                                              url:
                                                                  event.showUrl,
                                                            ),
                                                          )));
                                            },
                                            child: Image.network(
                                                'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/06/clickherefortickets-2048x471.png'),
                                          )
                                        : SizedBox(),
                                    event.formUrl != null &&
                                            event.formUrl.length > 10
                                        ? AwesomeButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Scaffold(
                                                            appBar: AppBar(
                                                              title: TitleText(
                                                                  'Buy Tickets'),
                                                            ),
                                                            body: MyWebView(
                                                              title:
                                                                  'Buy Tickets',
                                                              url:
                                                                  event.formUrl,
                                                            ),
                                                          )));
                                            },
                                            child: Image.network(
                                                'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/06/pink-tablereservations-1-2048x471.png'),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),

                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),

                              // Event sharing tile
                              ListTile(
                                onTap: () async {
                                  // final url = await DynamicLinkService()
                                  //     .createEventsDynamicLink(
                                  //         event.title,
                                  //         event.description
                                  //             .toString()
                                  //             .substring(100),
                                  //         event.id);
                                  final url = await DynamicLinkService()
                                      .createShortEventLink(event.id);
                                  print(url);
                                },
                                leading: Icon(
                                  Icons.share,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: TitleText(
                                    'Share this event with your friends and family.'),
                              ),

                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),
                              // Event Details Row
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons.birthdayCake,
                                              color: Colors.pinkAccent,
                                              size: 40,
                                            ),
                                          ),
                                          SubtitleText(
                                            // ignore: unrelated_type_equality_checks
                                            '${event.ageLimit['21+'] == true ? '21+' : ''} ${event.ageLimit['18+'] == true ? '18+' : ''} ${event.ageLimit['All'] == true ? 'All' : ''}',
                                            textAlign: TextAlign.center,
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons.solidClock,
                                              color: Colors.pinkAccent,
                                              size: 40,
                                            ),
                                          ),
                                          SubtitleText(
                                            '' +
                                                DateFormat.jm().format(event
                                                    .timing['start']
                                                    .toDate()) +
                                                " - " +
                                                DateFormat.jm().format(event
                                                    .timing['end']
                                                    .toDate()),
                                            textAlign: TextAlign.center,
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await launchMap();
                                      },
                                      child: SizedBox(
                                        width: 80,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.searchLocation,
                                                color: Colors.pinkAccent,
                                                size: 40,
                                              ),
                                            ),
                                            SubtitleText(
                                              event.venue,
                                              textAlign: TextAlign.center,
                                              fontSize: 14,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),

                              // Description
                              ListTile(
                                title: TitleText('About'),
                                subtitle: Column(
                                  children: MarkdownGenerator(
                                    data: event.description,
                                    styleConfig: StyleConfig(
                                        markdownTheme: MarkdownTheme.darkTheme),
                                  ).widgets,
                                ),
                              ),
                              // Flexible(
                              //   child: Markdown(data: event.description),
                              // ),
                              // Container(
                              //   height: 800,
                              //   width: MediaQuery.of(context).size.width,
                              //   child: ListTile(
                              //     title: TitleText('About'),
                              //     subtitle: Markdown(data: event.description),
                              //   ),
                              // ),

                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),

                              // Youtube embeded
                              event.videoUrl != null &&
                                      event.videoUrl.length > 0
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      height: 300,
                                      child: MyEmbededView(
                                        url: 'https://youtube.com/embed/' +
                                            event.videoUrl.split('/')[event
                                                    .videoUrl
                                                    .split('/')
                                                    .length -
                                                1],
                                      ),
                                    )
                                  : SizedBox.shrink(),

                              // Spotify embeded
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: 300,
                                child: MyEmbededView(
                                  url: event.spotifyUrl != null &&
                                          event.spotifyUrl.length > 0
                                      ? 'https://open.spotify.com/embed/' +
                                          event.spotifyUrl.replaceAll(
                                              'https://open.spotify.com/', '')
                                      : 'https://open.spotify.com/embed/playlist/18J3XQtV69OEWkrpBKj4gL',
                                  // javascriptMode: JavascriptMode.unrestricted,
                                ),
                              ),

                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),

                              ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText('Map'),
                                    IconButton(
                                        onPressed: launchMap,
                                        icon: Icon(
                                            FontAwesomeIcons.locationArrow))
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                      height: 200,
                                      child: MapLayoutBuilder(
                                        controller: controller,
                                        builder: (context, transformer) {
                                          return Stack(
                                            children: [
                                              GestureDetector(
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
                                                    final lightUrl =
                                                        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                                                    return CachedNetworkImage(
                                                      imageUrl: lightUrl,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                              _buildMarkerWidget(
                                                  transformer
                                                      .fromLatLngToXYCoords(
                                                          LatLng(
                                                              35.68, 51.412)),
                                                  Colors.green),
                                            ],
                                          );
                                        },
                                      )),
                                ),
                              ),
                              Divider(
                                indent: 10,
                                thickness: 1.0,
                                endIndent: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      // bottomNavigationBar: ScaleAnimation(
      //   child: Container(
      //     height: 200,
      //     color: Theme.of(context).cardColor.withOpacity(0.5),
      //     child: Flex(
      //       direction: Axis.vertical,
      //       children: [
      //         Flexible(
      //           child: AwesomeButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => Scaffold(
      //                             appBar: AppBar(
      //                               title: TitleText('Buy Tickets'),
      //                             ),
      //                             body: MyWebView(
      //                               title: 'Buy Tickets',
      //                               url: event.listingUrl,
      //                             ),
      //                           )));
      //             },
      //             child: Image.network(
      //                 'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/06/clickherefortickets-2048x471.png'),
      //           ),
      //         ),
      //         Flexible(
      //           child: AwesomeButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => Scaffold(
      //                             appBar: AppBar(
      //                               title: TitleText('Buy Tickets'),
      //                             ),
      //                             body: MyWebView(
      //                               title: 'Buy Tickets',
      //                               url: event.listingUrl,
      //                             ),
      //                           )));
      //             },
      //             child: Image.network(
      //                 'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/06/pink-tablereservations-1-2048x471.png'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
