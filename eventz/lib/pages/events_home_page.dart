import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_containers.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/events_details.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EventsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = AuthService().auth.currentUser;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 310,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          height: 270,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0).add(
                              EdgeInsets.only(bottom: 20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: SubtitleText(
                                                  'Hey ${user.displayName} 👋,'),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: SubtitleText(
                                                  DateFormat('EEE, dd MMMM')
                                                      .format(DateTime.now())),
                                            ),
                                            TitleText(
                                              'Find the amazing events near you.',
                                              fontSize: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ScaleAnimation(
                                            child: Image.asset(
                                              GlobalValues.searchImage,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: ScaleAnimation(
                              duration: 1,
                              child: SearchBar(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0)
                        .add(EdgeInsets.symmetric(horizontal: 10.0)),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _EventHeading(
                      title: 'Weekly Events',
                      image: 'images/illustrations/back_1.jpeg',
                      subtitle: 'Find out the best events ocuuring every week.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _EventHeading(
                      title: 'New this Weekend',
                      image: 'images/illustrations/back_2.jpeg',
                      subtitle: 'Find out what\'s new this weekend.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _EventHeading(
                      title: 'Chill Sunday',
                      image: 'images/illustrations/back_3.jpeg',
                      subtitle:
                          'Find events to chill yourself out this sunday.',
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          )
                        ],
                        // border:
                        //     Border.all(color: Theme.of(context).accentColor),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          ListTile(
                            title: TitleText('See you again'),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white, // Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2.0),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    hintText: 'Search location', border: InputBorder.none),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Icon(
              FontAwesomeIcons.search,
              color: Colors.grey,
            ),
          ),
        ],
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
          ScaleAnimation(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    width: 3.0,
                  )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: FadeAnimation(0.5, image),
              ),
            ),
          ),
          FadeAnimation(
            0.2,
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: title,
            ),
          ),
        ],
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
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
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
                              children: [
                                EventTile(
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
                                EventTile(
                                  imageURL: 'images/posters/baila.jpeg',
                                  title: 'DJ JStar',
                                  subtitle: 'Baila Fridays',
                                  creator: 'V5',
                                  distance: '1.2',
                                  date: DateTime(2021, 2, 5),
                                  description:
                                      'Tonight is going to be an awesome night. Get ready to rock your world.',
                                  ticketPrice: '18.4',
                                ),
                                EventTile(
                                  imageURL: 'images/posters/luxur.jpeg',
                                  title: 'DJ OZONE',
                                  subtitle: 'Luxur Saturdays',
                                  creator: 'V5',
                                  distance: '2.4',
                                  date: DateTime(2021, 3, 12),
                                  description:
                                      'Tonight is going to be an awesome night. Get ready to rock your world.',
                                  ticketPrice: '18.4',
                                ),
                                EventTile(
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        child: AwesomeButton(
                          isExpanded: true,
                          height: 45,
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
                          child: SubtitleText('View All'),
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
                          }),
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
  final bool isVerticle;
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
      @required this.subtitle})
      : super(key: key);

  factory EventTile.verticle(
      {String imageURL,
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

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    return widget.isVerticle
        ? Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              // color: Theme.of(context).cardColor,
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Theme.of(context).accentColor,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
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
                                          )));
                            },
                            child: Container(
                              width: 250,
                              height: 300,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        // width: 40,
                        margin: EdgeInsets.all(6.0),
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.8),
                                Colors.white.withOpacity(0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                              )
                            ]),
                        child: SubtitleText(
                          DateFormat('MMM, d').format(widget.date),
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
                TitleText(
                  widget.title,
                  maxLines: 2,
                ),
                SubtitleText('at ${widget.subtitle}'),
                SubtitleText(
                  '${widget.distance} km away',
                  fontWeight: FontWeight.w900,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: AwesomeButton(
                    width: 250,
                    height: 40,
                    onPressed: () {},
                    buttonStyle: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (_) => Theme.of(context).primaryColor),
                    ),
                    buttonType: AwesomeButtonType.elevated,
                    child: SubtitleText(
                      'Get Tickets for \$${widget.ticketPrice}',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : InkWell(
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
                          )));
            },
            child: Container(
              // height: 180,
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(widget.imageURL),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.2),
                  )
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black.withOpacity(0.3),
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SubtitleText(
                            DateFormat('MMM, d').format(widget.date),
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          TitleText(widget.title,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white),
                          SubtitleText(
                            'at ${widget.subtitle}',
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                      height: 10.0,
                    ),
                    Expanded(
                      child: AwesomeButton(
                        onPressed: () {},
                        buttonStyle: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith(
                              (_) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (_) => Colors.grey.shade200)),
                        height: 40,
                        buttonType: AwesomeButtonType.elevated,
                        child: SubtitleText(
                          'Get Tickets',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
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
      String distance})
      : super(
            imageURL: imageURL,
            title: title,
            creator: creator,
            date: date,
            subtitle: subtitle,
            description: description,
            ticketPrice: ticketPrice,
            distance: distance,
            isVerticle: true);
}
