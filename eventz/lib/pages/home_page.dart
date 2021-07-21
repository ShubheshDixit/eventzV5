import 'dart:ui';
import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/events_home_page.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentIndex = 0;
  TabController _controller;

  var selectedDate;
  bool isMenuOn = false;
  bool isVip = false;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 6, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = _controller.index;
        });
      });
  }

  void changePage(index) {
    _controller.animateTo(index);
    setState(() {
      currentIndex = index;
      isMenuOn = !isMenuOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            right: isMenuOn ? 300 : 0,
            child: Transform.scale(
              scale: isMenuOn ? 0.85 : 1,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceIn,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: isMenuOn
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                            color: Theme.of(context).cardColor, width: 8.0),
                      )
                    : BoxDecoration(),
                child: ClipRRect(
                  borderRadius: isMenuOn
                      ? BorderRadius.circular(25.0)
                      : BorderRadius.circular(0),
                  child: EventsHomePage(
                    onMenuPressed: () {
                      setState(() {
                        isMenuOn = !isMenuOn;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            right: 0,
            child: Container(
              width: isMenuOn ? 300 : 0,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: !isMenuOn
                  ? SizedBox()
                  : FadeAnimation(
                      0.2,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            GlobalValues.logoImageBlue,
                            height: 80,
                          ),
                          ListTile(
                            title: TitleText(
                              'Musica',
                              color: GlobalValues.primaryColor,
                            ),
                            subtitle: SubtitleText('is Our Business'),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor
                                  ]),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                Routemaster.of(context).push('/vip');
                              },
                              title: TitleText(
                                isVip ? 'VIP Member' : 'Get VIP Membership',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              subtitle: Text(
                                isVip
                                    ? 'Your VIP membership expires soon.'
                                    : 'Become a vip member and enjoy special benefits.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Image.asset(
                                GlobalValues.crownImage,
                              ),
                            ),
                          ),
                          Divider(),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Routemaster.of(context).push('/');
                                      setState(() {
                                        currentIndex = 0;
                                      });
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.home,
                                      color: currentIndex == 0
                                          ? null
                                          : Colors.grey,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'Home',
                                      color: currentIndex == 0
                                          ? null
                                          : Colors.grey,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Routemaster.of(context).push('/store');
                                      setState(() {
                                        currentIndex = 1;
                                      });
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.store,
                                      color: currentIndex == 1
                                          ? null
                                          : Colors.grey,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'Store',
                                      color: currentIndex == 1
                                          ? null
                                          : Colors.grey,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Routemaster.of(context).push('/tickets');
                                      setState(() {
                                        currentIndex = 2;
                                      });
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.ticketAlt,
                                      color: currentIndex == 2
                                          ? null
                                          : Colors.grey,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'My Tickets',
                                      color: currentIndex == 2
                                          ? null
                                          : Colors.grey,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Routemaster.of(context).push('/gallery');
                                      setState(() {
                                        currentIndex = 3;
                                      });
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.image,
                                      color: currentIndex == 3
                                          ? null
                                          : Colors.grey,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'Gallery',
                                      color: currentIndex == 3
                                          ? null
                                          : Colors.grey,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Routemaster.of(context)
                                          .push('/photobooth');
                                      setState(() {
                                        currentIndex = 4;
                                      });
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.cameraRetro,
                                      color: currentIndex == 4
                                          ? null
                                          : Colors.grey,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'PhotoBooth',
                                      color: currentIndex == 4
                                          ? null
                                          : Colors.grey,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Routemaster.of(context).push('/contact');
                                      setState(() {
                                        currentIndex = 5;
                                      });
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.infoCircle,
                                      color: currentIndex == 5
                                          ? null
                                          : Colors.grey,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'More',
                                      color: currentIndex == 5
                                          ? null
                                          : Colors.grey,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () async {
                                      await AuthService().logout();
                                      Routemaster.of(context).replace('/auth');
                                    },
                                    leading: Icon(
                                      FontAwesomeIcons.signOutAlt,
                                      color: GlobalValues.primaryColor,
                                    ),
                                    minLeadingWidth: 0,
                                    title: TitleText(
                                      'Logout',
                                      color: GlobalValues.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SubtitleText(
                                        'Version : 1.0',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SubtitleText(
                                        'App is up to date',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                FloatingActionButton(
                                  heroTag: 'close_stack_menu',
                                  onPressed: () {
                                    setState(() {
                                      isMenuOn = !isMenuOn;
                                    });
                                  },
                                  backgroundColor: GlobalValues.primaryColor,
                                  child: Icon(Icons.close),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalenderPopUp extends StatefulWidget {
  final VoidCallback onDateSelected, onClosePressed;
  const CalenderPopUp(
      {Key key, @required this.onDateSelected, @required this.onClosePressed})
      : super(key: key);
  @override
  _CalenderPopUpState createState() => _CalenderPopUpState();
}

class _CalenderPopUpState extends State<CalenderPopUp> {
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TitleText(
                'When is your event?',
                fontSize: 23,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
              IconButton(
                  icon: Icon(FontAwesomeIcons.timesCircle),
                  onPressed: () => widget.onClosePressed())
            ],
          ),
          // TableCalendar(
          //   onDaySelected: (day, events, holidays) {
          //     setState(() {
          //       selectedDate = day;
          //     });
          //   },
          //   daysOfWeekStyle: DaysOfWeekStyle(
          //     weekendStyle: TextStyle(color: Colors.grey),
          //     weekdayStyle: TextStyle(color: Colors.grey),
          //   ),
          //   headerStyle: HeaderStyle(
          //     centerHeaderTitle: false,
          //     formatButtonVisible: false,
          //     headerPadding: EdgeInsets.only(left: 4.0),
          //     headerMargin: EdgeInsets.symmetric(vertical: 18.0),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8.0),
          //       border: Border.all(
          //           color: Theme.of(context).textTheme.bodyText1.color),
          //     ),
          //     titleTextStyle: TextStyle(
          //         color: Theme.of(context).textTheme.bodyText1.color,
          //         fontSize: 22),
          //     leftChevronIcon: Icon(
          //       FontAwesomeIcons.caretLeft,
          //       color: Theme.of(context).textTheme.bodyText1.color,
          //     ),
          //     rightChevronIcon: Icon(
          //       FontAwesomeIcons.caretRight,
          //       color: Theme.of(context).textTheme.bodyText1.color,
          //     ),
          //   ),
          //   calendarStyle: CalendarStyle(
          //     contentPadding: EdgeInsets.zero,
          //     markersColor: Theme.of(context).accentColor,
          //     selectedColor: Theme.of(context).primaryColor,
          //     todayColor: Theme.of(context).primaryColor.withOpacity(0.5),
          //     outsideDaysVisible: false,
          //     weekendStyle: TextStyle(
          //       color: Theme.of(context).textTheme.bodyText1.color,
          //     ),
          //     weekdayStyle: TextStyle(
          //       color: Theme.of(context).textTheme.bodyText1.color,
          //     ),
          //   ),
          //   calendarController: widget.calendarController,
          // ),
          selectedDate == null
              ? SizedBox.shrink()
              : AwesomeButton(
                  height: 50,
                  onPressed: widget.onDateSelected,
                  buttonType: AwesomeButtonType.elevated,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SubtitleText(
                        DateFormat('dd MMMM, yyyy').format(selectedDate),
                        color: Colors.white,
                      ),
                      Icon(
                        FontAwesomeIcons.arrowRight,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
