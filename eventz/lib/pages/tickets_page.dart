import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/add_events.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class TicketsPage extends StatefulWidget {
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with TickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4.0,
        title: TitleText('My Tickets',
            color: Theme.of(context).textTheme.bodyText1.color),
        bottom: TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              child: SubtitleText(
                'Upcoming',
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
            Tab(
              child: SubtitleText('Past',
                  color: Theme.of(context).textTheme.bodyText1.color),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                TicketTile(
                  imageURL: 'images/posters/luxur.jpeg',
                  title: 'Luxur Saturdays \nDJ Ozone',
                  creator: 'V5',
                  date: 'Sept 18',
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPopUp(
                  title: 'No past tickets',
                  height: 360,
                  subtitle: 'Explore tickets page to find out amazing events.',
                  image: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset(GlobalValues.errorImage),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketTile extends StatefulWidget {
  final String imageURL,
      title,
      creator,
      date,
      distance,
      description,
      ticketPrice;
  final bool isVerticle;

  const TicketTile(
      {Key key,
      this.imageURL,
      this.title,
      this.creator,
      this.date,
      this.distance,
      this.ticketPrice,
      this.description,
      this.isVerticle = false})
      : super(key: key);

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketView(
              title: widget.title,
              boughtDate: 'Mon, June 10 2021',
              eventDate: 'Fri, September 18 2021',
              barcode: '48512657841',
              imageURL: widget.imageURL,
              place: 'WB Adam Club, Winsten, NY',
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: widget.imageURL,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 150,
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.withOpacity(0.7),
                            Colors.white.withOpacity(0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        // border: Border.all(color: Colors.black, width: 2.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ]),
                    child: SubtitleText(
                      widget.date,
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
              width: 10.0,
              height: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(
                    widget.title,
                    maxLines: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        'Bought on',
                        color: Colors.grey,
                      ),
                      SubtitleText('Mon, June 10 2021')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        'Event Date',
                        color: Colors.grey,
                      ),
                      SubtitleText('Fri, September 18 2021')
                    ],
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

class TicketView extends StatelessWidget {
  final String imageURL, title, boughtDate, eventDate, place, barcode;

  const TicketView(
      {Key key,
      @required this.imageURL,
      @required this.title,
      @required this.boughtDate,
      @required this.eventDate,
      @required this.place,
      @required this.barcode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: TitleText('My Tickets'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: imageURL,
                  child: Material(
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                        imageURL,
                        fit: BoxFit.cover,
                        width: 300,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TitleText(title),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        'Bought On',
                        color: Colors.grey,
                      ),
                      SubtitleText(boughtDate)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        'Event Date',
                        color: Colors.grey,
                      ),
                      SubtitleText(eventDate)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        'Event Venue',
                        color: Colors.grey,
                      ),
                      SubtitleText(place)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: 300,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.rotate(
                          angle: math.pi / 2,
                          alignment: Alignment.topCenter,
                          child: MyArc(
                            diameter: 40,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: DottedBorder(
                          color: Colors.grey,
                          borderType: BorderType.RRect,
                          padding: EdgeInsets.zero,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 0.4,
                          child: SizedBox(
                            height: 0.5,
                            width: 240,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          alignment: Alignment.topCenter,
                          child: MyArc(
                            diameter: 40,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: 30,
                  width: 300,
                  child: Column(
                    children: [
                      BarcodeWidget(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        barcode: Barcode.code128(),
                        data: '$barcode',
                        style: TextStyle(fontSize: 18),
                        width: 250,
                        height: 70,
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;
  final Color color;

  const MyArc({Key key, this.diameter = 200, this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(color),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  final Color color;

  MyPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
