import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/mock_data.dart';
import 'package:eventz/backend/models.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class AllEventsPage extends StatefulWidget {
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _controller,
            slivers: [
              SliverAppBar(
                title: TitleText('All Events'),
                leading: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                  ),
                  onPressed: () => Routemaster.of(context).pop(),
                ),
                brightness: Brightness.dark,
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 220,
                  alignment: Alignment.topCenter,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      height: 200,
                      child: FadeAnimation(
                        0.1,
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(
                                    'V5\'s Amazing Events',
                                    fontSize: 24,
                                  ),
                                  SubtitleText(
                                    'Come and enjoy.',
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
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
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 600,
                margin: EdgeInsets.only(top: 120),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(events.length + 1, (index) {
                      if (index == 0)
                        return SizedBox(
                          height: 160,
                        );
                      Event event = Event.fromMap(events[index - 1]);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: EventsBox(
                          isFull: true,
                          event: event,
                        ),
                      );
                    }),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class EventsBox extends StatefulWidget {
  final bool isFull, isTile;
  final Event event;

  const EventsBox(
      {Key key, this.isFull = false, @required this.event, this.isTile = false})
      : super(key: key);

  @override
  _EventsBoxState createState() => _EventsBoxState();
}

class _EventsBoxState extends State<EventsBox> {
  bool isHovered = false;
  var unescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: widget.isFull ? BorderRadius.circular(8.0) : null,
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
      child: InkWell(
        onTap: () async {
          print(widget.event.id);
          Routemaster.of(context).push('/event/${widget.event.id}');
        },
        child: widget.isTile
            ? Row(
                children: [
                  FancyShimmerImage(
                    imageUrl: widget.event.posterURL,
                    errorWidget: Image.network(
                        'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                    width: 100,
                    height: 140,
                  ),
                  // Image.network(
                  //   widget.event.posterURL,
                  //   width: 100,
                  //   height: 140,
                  //   fit: BoxFit.cover,
                  // ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          unescape.convert(widget.event.title),
                          maxLines: 2,
                          fontSize: 18,
                        ),
                        SubtitleText(
                          'at ${widget.event.subtitle}',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ))
                ],
              )
            : Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: widget.event.posterURL,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            height: 420,
                            decoration: BoxDecoration(
                              borderRadius: widget.isFull
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0))
                                  : null,
                              image: DecorationImage(
                                image: NetworkImage(widget.event.posterURL),
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
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: widget.isFull
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                )
                              : null,
                        ),
                        child: Column(
                          children: [
                            TitleText(
                              DateFormat('dd')
                                  .format(widget.event.date.toDate()),
                              maxLines: 1,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                            SubtitleText(
                              DateFormat('MMM')
                                  .format(widget.event.date.toDate()),
                              maxLines: 1,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  !widget.isFull
                      ? SizedBox.shrink()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                unescape.convert(widget.event.title),
                                maxLines: 2,
                                fontSize: 30,
                              ),
                              SubtitleText(
                                'at ${widget.event.subtitle}',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                              SubtitleText(
                                '${unescape.convert(widget.event.description)}',
                              ),
                              SubtitleText(
                                '2.5km away',
                                fontWeight: FontWeight.w900,
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
