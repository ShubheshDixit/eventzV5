import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_containers.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/backend/mock_data.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/events_details.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:eventz/pages/music_page.dart';
import 'package:eventz/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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

  bool isMenuOpen = false;

  int currentIndex = 0;

  TabController _controller, _tabController;

  AnimationController _animationController;

  var selectedDate;

  bool index = false;

  double dragStartPoint = 0, dragEndPoint = 0;

  @override
  void initState() {
    super.initState();
    _key = LabeledGlobalKey("button_icon");

    initializeDateFormatting();
    Intl.systemLocale = 'en_En';

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
    );
    _controller = TabController(vsync: this, length: 2);
    _tabController = TabController(length: 3, vsync: this);

    Timer(Duration(seconds: 3), () {
      Timer.periodic(Duration(seconds: 5), (timer) {
        if (mounted)
          setState(() {
            index = !index;
          });
        _controller.animateTo(index ? 1 : 0,
            duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = AuthService().auth.currentUser;
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(
        '<!DOCTYPE html><html><body><iframe src="https://open.spotify.com/embed/playlist/18J3XQtV69OEWkrpBKj4gL" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe></body></html>'));
    return Scaffold(
      appBar: v5AppBar(context, onPressed: widget.onMenuPressed),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Theme.of(context).primaryColor,
                  //     Theme.of(context).accentColor,
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                height: 250,
                width: 400,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Colors.white,
                        ),
                      ),
                      TitleText(
                        'Find the amazing events near you.',
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ).add(EdgeInsets.symmetric(horizontal: 20.0)),
                    child: Container(
                      height: 70,
                      width: 500,
                      child: TabBarView(
                        controller: _controller,
                        children: [
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //   height: 135,
                  //   child: WebView(
                  //     initialUrl:
                  //         'https://widget.taggbox.com/widget/index.html?wall_id=54746',
                  //     javascriptMode: JavascriptMode.unrestricted,
                  //   ),
                  // ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0)
                          .add(EdgeInsets.symmetric(horizontal: 20.0)),
                      child: FadeAnimation(
                        0.3,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageColumnTile(
                              image: Image.asset(
                                'images/posters/jazz.jpg',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              title: SubtitleText(
                                'Happening Tonight',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ImageColumnTile(
                              image: Image.asset(
                                'images/posters/rock.jpg',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              title: SubtitleText(
                                'Weekend Highlights',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ImageColumnTile(
                              image: Image.asset(
                                'images/posters/magic.jpg',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              title: SubtitleText(
                                'Birthday Events',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    controller: _tabController,
                    enableFeedback: true,
                    indicator: CircleTabIndicator(
                        color: Theme.of(context).accentColor, radius: 4),
                    tabs: [
                      Tab(
                        text: 'Weekly Events',
                      ),
                      Tab(
                        text: 'Popular',
                      ),
                      Tab(
                        text: 'Happening Tonight',
                      ),
                    ],
                  ),
                  FadeAnimation(
                    0.4,
                    Container(
                      height: 400,
                      margin: EdgeInsets.only(top: 10.0),
                      // color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child:
                            TabBarView(controller: _tabController, children: [
                          EventsTabView(),
                          PopularEvents(),
                          EventsTabView(),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    _animationController.reverse();
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void openMenu() {
    findButton();
    _animationController.forward();
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
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).scaffoldBackgroundColor,
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
            fontSize: 16,
          ),
          subtitle: SubtitleText(
            'Enjoy amazing DJ mixes.',
            fontSize: 14,
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
        color: Theme.of(context).scaffoldBackgroundColor,
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
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  FontAwesomeIcons.search,
                  color: GlobalValues.primaryColor,
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints(maxWidth: 100, minWidth: 30),
              hintText: 'Search events, DJs',
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

          // FadeAnimation(
          //   0.2,
          //   Padding(
          //     padding: const EdgeInsets.only(top: 10.0),
          //     child: title,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class EventsTabView extends StatefulWidget {
  final bool isExpanded;

  const EventsTabView({Key key, this.isExpanded = false}) : super(key: key);
  @override
  _EventsTabViewState createState() => _EventsTabViewState();
}

class _EventsTabViewState extends State<EventsTabView> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(eventsList.length + 1, (index) {
            return index == eventsList.length
                ? SizedBox(
                    width: 20,
                  )
                : Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                    child: ScaleAnimation(
                      // (index + 1) / 10,
                      child: EventTile(
                          isFull: widget.isExpanded,
                          imageURL: eventsList[index].posterURL,
                          title: eventsList[index].title,
                          creator: eventsList[index].creatorName,
                          date: eventsList[index].date.toDate(),
                          distance: '0.8',
                          ticketPrice: eventsList[index].ticketPrice.toString(),
                          description: eventsList[index].description,
                          subtitle: eventsList[index].subtitle),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}

class PopularEvents extends StatelessWidget {
  final bool isExpanded;

  const PopularEvents({Key key, this.isExpanded}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleAnimation(
              child: EventTile(
                isFull: isExpanded,
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
            ScaleAnimation(
              child: EventTile(
                isFull: isExpanded,
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
            ScaleAnimation(
              child: EventTile(
                isFull: isExpanded,
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
            ScaleAnimation(
              child: EventTile(
                isFull: isExpanded,
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
            ScaleAnimation(
              child: EventTile(
                isFull: isExpanded,
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
            SizedBox(width: 20),
          ].reversed.toList(),
        ),
      ),
    );
  }
}

class _EventHeading extends StatefulWidget {
  final String title, image, subtitle;

  const _EventHeading(
      {Key key,
      @required this.image,
      @required this.title,
      @required this.subtitle})
      : super(key: key);
  @override
  _EventHeadingState createState() => _EventHeadingState();
}

class _EventHeadingState extends State<_EventHeading>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AwesomeContainer(
        isActionHidden: true,
        isLabelHidden: true,
        topChildHeight: 200,
        topChildWidth: 500,
        containerDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Theme.of(context).cardColor,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              )
            ]),
        bodyWidget: AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 300),
          child: !isExpanded
              ? SizedBox.shrink()
              : Container(
                  padding: EdgeInsets.only(bottom: 10, top: 10.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Scrollbar(
                        radius: Radius.circular(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children:
                                  List.generate(eventsList.length, (index) {
                                return EventTile(
                                    imageURL: eventsList[index].posterURL,
                                    title: eventsList[index].title,
                                    creator: eventsList[index].creatorName,
                                    date: eventsList[index].date.toDate(),
                                    distance: '0.8',
                                    ticketPrice: eventsList[index]
                                        .ticketPrice
                                        .toString(),
                                    description: eventsList[index].description,
                                    subtitle: eventsList[index].subtitle);
                              }),
                            ),
                          ),
                        ),
                      ),
                      // Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        child: AwesomeButton(
                          isExpanded: true,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullEventsPage(
                                  posterUrl: widget.image,
                                  title: widget.title,
                                  subtitle: widget.subtitle,
                                ),
                              ),
                            );
                          },
                          buttonType: AwesomeButtonType.outline,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SubtitleText(
                              'View All',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
        title: Hero(
          tag: widget.image,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullEventsPage(
                      posterUrl: widget.image,
                      title: widget.title,
                      subtitle: widget.subtitle,
                    ),
                  ),
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: isExpanded
                      ? BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        )
                      : BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: AssetImage(widget.image), fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TitleText(
                        widget.title,
                        fontSize: 30,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 50,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        splashRadius: 25,
                        icon: Icon(
                          isExpanded
                              ? FontAwesomeIcons.chevronUp
                              : FontAwesomeIcons.chevronDown,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventTile extends StatefulWidget {
  final String imageURL,
      title,
      subtitle,
      creator,
      distance,
      description,
      ticketPrice;
  final bool isVerticle, isMine, isFull;
  final DateTime date;

  const EventTile(
      {Key key,
      @required this.imageURL,
      @required this.title,
      @required this.creator,
      @required this.date,
      @required this.distance,
      @required this.ticketPrice,
      @required this.description,
      this.isVerticle = false,
      this.isMine = false,
      this.isFull = false,
      @required this.subtitle})
      : super(key: key);

  factory EventTile.verticle(
      {String imageURL,
      bool isMine,
      bool isFull,
      @required String title,
      @required String subtitle,
      @required String creator,
      @required DateTime date,
      @required String description,
      @required String ticketPrice,
      @required String distance}) = _EventTileVerticle;
  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> with TickerProviderStateMixin {
  bool isHovered = false;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFull
        ? SizedBox(
            width: widget.isVerticle ? 200 : 480,
            height: widget.isVerticle ? 560 : 360,
            child: Hero(
              tag: widget.imageURL,
              child: Material(
                color: Colors.transparent,
                child: Transform.scale(
                  scale: isHovered ? 0.95 : 1,
                  child: InkWell(
                    onHover: (value) {
                      setState(() {
                        isHovered = value;
                      });
                    },
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetails(
                            title: widget.title,
                            subtitle: widget.subtitle,
                            description: widget.description,
                            date: widget.date,
                            creator: widget.creator,
                            imageURL: widget.imageURL,
                            distance: widget.distance,
                            ticketPrice: widget.ticketPrice,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            offset: Offset(1, 3),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.2),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flex(
                            direction: widget.isVerticle
                                ? Axis.vertical
                                : Axis.horizontal,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(widget.imageURL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    height: 70,
                                    width: 60,
                                    color: Colors.black.withOpacity(0.6),
                                    child: Column(
                                      children: [
                                        TitleText(
                                          DateFormat('dd').format(widget.date),
                                          maxLines: 1,
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                        SubtitleText(
                                          DateFormat('MMM').format(widget.date),
                                          maxLines: 1,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                width: 240,
                                height: 300,
                                padding: EdgeInsets.only(left: 15)
                                    .add(EdgeInsets.symmetric(vertical: 10.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleText(
                                      widget.title,
                                      maxLines: 2,
                                      fontSize: 30,
                                    ),
                                    SubtitleText(
                                      '10:00 - 14:00',
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    SubtitleText('at ${widget.subtitle}'),
                                    SubtitleText(
                                      '${widget.distance} km away',
                                      fontWeight: FontWeight.w900,
                                    ),
                                    SubtitleText(
                                      '${widget.description}',
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: widget.isMine ? 120 : 200,
                                color: Theme.of(context).cardColor,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TitleText(
                                        '\$${widget.ticketPrice}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: SubtitleText(
                                          '/PERSON',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 60,
                                  color: Theme.of(context).primaryColor,
                                  child: AwesomeButton(
                                    width: widget.isMine ? 100 : 300,
                                    height: 40,
                                    onPressed: () {},
                                    buttonType: AwesomeButtonType.text,
                                    child: SubtitleText(
                                      'BOOK THIS EVENT',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Theme.of(context).cardColor,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Hero(
              tag: widget.imageURL,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetails(
                          title: widget.title,
                          subtitle: widget.subtitle,
                          description: widget.description,
                          date: widget.date,
                          creator: widget.creator,
                          imageURL: widget.imageURL,
                          distance: widget.distance,
                          ticketPrice: widget.ticketPrice,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 240,
                        height: 420,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.imageURL),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              offset: Offset(1, 3),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.2),
                            )
                          ],
                        ),
                        child: Container(
                            // color: Colors.black.withOpacity(0.3),
                            ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        width: 60,
                        height: 70,
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            TitleText(
                              DateFormat('dd').format(widget.date),
                              maxLines: 1,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                            SubtitleText(
                              DateFormat('MMM').format(widget.date),
                              maxLines: 1,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: Container(
                      //     padding: EdgeInsets.all(10.0),
                      //     color: Colors.black.withOpacity(0.5),
                      //     width: 240,
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         TitleText(
                      //           widget.title,
                      //           maxLines: 2,
                      //           fontSize: 30,
                      //           shadows: [
                      //             BoxShadow(
                      //                 color: Colors.black,
                      //                 spreadRadius: 1,
                      //                 blurRadius: 5)
                      //           ],
                      //         ),
                      //         SubtitleText(
                      //           'at ${widget.subtitle}',
                      //           shadows: [
                      //             BoxShadow(
                      //                 color: Colors.black,
                      //                 spreadRadius: 1,
                      //                 blurRadius: 5)
                      //           ],
                      //         ),
                      //         SubtitleText(
                      //           '${widget.distance} km away',
                      //           fontWeight: FontWeight.w900,
                      //           shadows: [
                      //             BoxShadow(
                      //                 color: Colors.black,
                      //                 spreadRadius: 1,
                      //                 blurRadius: 5)
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class _EventTileVerticle extends EventTile {
  _EventTileVerticle(
      {String imageURL,
      String title,
      String subtitle,
      String creator,
      DateTime date,
      String description,
      String ticketPrice,
      bool isMine = false,
      bool isFull = false,
      String distance})
      : super(
            imageURL: imageURL,
            title: title,
            creator: creator,
            date: date,
            isFull: isFull,
            isMine: isMine,
            subtitle: subtitle,
            description: description,
            ticketPrice: ticketPrice,
            distance: distance,
            isVerticle: true);
}

AppBar v5AppBar(context, {onPressed}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).primaryColor,
    elevation: 0.0,
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
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w900,
                    ),
                    SubtitleText('is'),
                  ],
                ),
                SubtitleText('Our Business')
              ],
            )
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            FontAwesomeIcons.bars,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
      ],
    ),
  );
}
