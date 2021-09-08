import 'dart:async';
import 'dart:ui';
import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/backend/models.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/all_events_page.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:eventz/pages/music_page.dart';
import 'package:eventz/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shimmer/shimmer.dart';

class EventsHomePage extends StatefulWidget {
  final VoidCallback onMenuPressed;
  const EventsHomePage({Key key, this.onMenuPressed}) : super(key: key);

  @override
  _EventsHomePageState createState() => _EventsHomePageState();
}

class _EventsHomePageState extends State<EventsHomePage>
    with TickerProviderStateMixin {
  GlobalKey _key = LabeledGlobalKey("button_icon");

  OverlayEntry _overlayEntry;

  Size buttonSize;

  Offset buttonPosition;

  bool isMenuOpen = false, isLoading = true;

  int currentIndex = 0;

  TabController _controller;

  var selectedDate;

  bool index = false;

  double dragStartPoint = 0, dragEndPoint = 0;

  @override
  void initState() {
    super.initState();
    _key = LabeledGlobalKey("button_icon");

    initializeDateFormatting();
    Intl.systemLocale = 'en_En';

    _controller = TabController(vsync: this, length: 2);

    Timer(Duration(seconds: 1), () {
      if (mounted)
        setState(() {
          isLoading = false;
        });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = AuthService().auth.currentUser;
    // final String contentBase64 = base64Encode(const Utf8Encoder().convert(
    //     '<!DOCTYPE html><html><body><iframe src="https://open.spotify.com/embed/playlist/18J3XQtV69OEWkrpBKj4gL" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe></body></html>'));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Image.asset(
                  GlobalValues.logoImage,
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SubtitleText(
                          'Musica ',
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                        SubtitleText(
                          'is',
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ],
                    ),
                    SubtitleText(
                      'Our Business',
                      color: Theme.of(context).textTheme.bodyText1.color,
                    )
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: widget.onMenuPressed,
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Container(
            //   height: 300,
            //   color: Theme.of(context).canvasColor,
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: TitleText(
                            'Hey ${user.displayName} 👋,',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 5),
                              child: Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.grey[300],
                                size: 16,
                              ),
                            ),
                            Flexible(
                              child: TitleText(
                                  'Find the amazing events near you.',
                                  fontSize: 14,
                                  textAlign: TextAlign.left,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: Container(
                              height: 70,
                              width: 500,
                              child: CarouselSlider(
                                  items: [
                                    ScaleAnimation(
                                      duration: 1,
                                      child: MusicBar(), //SearchBar(),
                                    ),
                                    ScaleAnimation(
                                      duration: 1,
                                      child: Hero(
                                        tag: 'search_text_bar',
                                        child: Material(
                                            color: Colors.transparent,
                                            child: SearchBar()),
                                      ),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Routemaster.of(context).push('/booking');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                                'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/08/whiteleterr.png'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TitleText(
                                    'Weekly Events',
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                  child: AwesomeButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllEventsPage()));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SubtitleText('View All',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            color: Colors.transparent,
                                            child: FaIcon(
                                              FontAwesomeIcons.angleRight,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    buttonType: AwesomeButtonType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('events')
                              .where('eventType', isEqualTo: 'weekly')
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Column(
                                children: List.generate(5, (index) {
                                  return ShimmerTile();
                                }),
                              );
                            } else {
                              return Column(
                                children: List.generate(
                                    snapshot.data.docs.length, (index) {
                                  Event event =
                                      Event.fromDoc(snapshot.data.docs[index]);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: EventsBox(
                                      isTile: true,
                                      isFull: false,
                                      event: event,
                                    ),
                                  );
                                }),
                              );
                            }
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TitleText(
                                    'Special Events',
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                  child: AwesomeButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllEventsPage()));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SubtitleText('View All',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            color: Colors.transparent,
                                            child: FaIcon(
                                              FontAwesomeIcons.angleRight,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    buttonType: AwesomeButtonType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('events')
                              .where('eventType', isEqualTo: 'special')
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Column(
                                children: List.generate(5, (index) {
                                  return ShimmerTile();
                                }),
                              );
                            } else {
                              return Column(
                                children: List.generate(
                                    snapshot.data.docs.length, (index) {
                                  Event event =
                                      Event.fromDoc(snapshot.data.docs[index]);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: EventsBox(
                                      isTile: true,
                                      isFull: false,
                                      event: event,
                                    ),
                                  );
                                }),
                              );
                            }
                          },
                        ),
                        // Divider(
                        //   color: Colors.white,
                        //   indent: 8,
                        //   endIndent: 8,
                        // ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    // _animationController.reverse();
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void openMenu() {
    findButton();
    // _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          widthFactor: 300,
          child: FadeAnimation(
            0.2,
            ScaleAnimation(
              child: Container(
                width: 300.0,
                margin: EdgeInsets.only(bottom: 95.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .canvasColor, //Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class MusicBar extends StatefulWidget {
  @override
  _MusicBarState createState() => _MusicBarState();
}

class _MusicBarState extends State<MusicBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        alignment: Alignment.center,
        width: 500,
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              // spreadRadius: 1.0,
            ),
          ],
        ),
        child: ListTile(
          isThreeLine: true,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MusicPage()));
          },
          title: SubtitleText(
            'Listen to music on the go',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            // color: Colors.white,
          ),
          subtitle: SubtitleText(
            'Enjoy amazing DJ mixes.',
            fontSize: 12,
            color: Colors.grey,
          ),
          trailing: Icon(
            FontAwesomeIcons.solidPlayCircle,
            size: 35,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final bool isReadOnly;
  final Function(String text) onSubmitted;
  final TextEditingController controller;

  const SearchBar(
      {Key key, this.isReadOnly = true, this.controller, this.onSubmitted})
      : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 500,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            // spreadRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: widget.controller,
          readOnly: widget.isReadOnly,
          onSubmitted: widget.onSubmitted,
          onTap: () {
            if (widget.isReadOnly)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
          },
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  FontAwesomeIcons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints(maxWidth: 100, minWidth: 30),
              hintText: 'Search events, DJs',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class ImageColumnTile extends StatelessWidget {
  final Widget image;
  final Widget title;

  const ImageColumnTile({Key key, @required this.image, @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  // color: Theme.of(context).textTheme.bodyText1.color,
                  color: Colors.white,
                  width: 3.0,
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: image,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 10.0),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 500),
        baseColor: Colors.grey[800],
        highlightColor: Colors.grey[500],
        enabled: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: 40.0,
                    height: 8.0,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
