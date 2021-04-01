import 'dart:ui';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/add_events.dart';
import 'package:eventz/pages/events_home_page.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:eventz/pages/tickets_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey _key = LabeledGlobalKey("button_icon");
  OverlayEntry _overlayEntry;
  Size buttonSize;
  Offset buttonPosition;
  bool isMenuOpen = false;
  int currentIndex = 0;
  TabController _controller;
  CalendarController _calendarController;
  AnimationController _animationController;
  var selectedDate;

  @override
  void initState() {
    super.initState();
    _key = LabeledGlobalKey("button_icon");
    _controller = TabController(length: 4, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = _controller.index;
        });
      });
    initializeDateFormatting();
    Intl.systemLocale = 'en_En';
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void changePage(index) {
    _controller.animateTo(index);
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
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
                        SubtitleText('is'),
                      ],
                    ),
                    SubtitleText('Our Business')
                  ],
                )
              ],
            ),
            Icon(
              FontAwesomeIcons.bars,
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          EventsHomePage(),
          Container(),
          TicketsPage(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).cardColor,
        notchMargin: 2.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          padding: EdgeInsets.only(bottom: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  changePage(0);
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 0
                          ? FontAwesomeIcons.solidCompass
                          : FontAwesomeIcons.compass,
                      color: currentIndex == 0
                          ? Theme.of(context).accentColor
                          : Theme.of(context).textTheme.bodyText1.color,
                      size: 26,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  changePage(1);
                },
                padding: EdgeInsets.zero,
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 1
                          ? FontAwesomeIcons.solidMap
                          : FontAwesomeIcons.map,
                      color: currentIndex == 1
                          ? Theme.of(context).accentColor
                          : Theme.of(context).textTheme.bodyText1.color,
                      size: 22,
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  changePage(2);
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 2
                          ? FontAwesomeIcons.solidBookmark
                          : FontAwesomeIcons.bookmark,
                      color: currentIndex == 2
                          ? Theme.of(context).accentColor
                          : Theme.of(context).textTheme.bodyText1.color,
                      size: 22,
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  changePage(3);
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 3
                          ? FontAwesomeIcons.userAlt
                          : FontAwesomeIcons.user,
                      color: currentIndex == 3
                          ? Theme.of(context).accentColor
                          : Theme.of(context).textTheme.bodyText1.color,
                      size: 22,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        key: _key,
        child: AnimatedIconButton(
          size: 35,
          animationController: _animationController,
          onPressed: () {
            if (isMenuOpen) {
              closeMenu();
            } else {
              openMenu();
            }
          },
          endIcon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          startIcon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onPressed: () {},
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
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Align(
          alignment: Alignment.bottomRight,
          widthFactor: 300,
          child: FadeAnimation(
            0.2,
            ScaleAnimation(
              child: Container(
                width: 300.0,
                margin: EdgeInsets.only(bottom: 95.0, right: 20.0),
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
                child: CalenderPopUp(
                  calendarController: _calendarController,
                  onDateSelected: () async {
                    closeMenu();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEventsPage(
                          eventDate: _calendarController.selectedDay,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CalenderPopUp extends StatefulWidget {
  final CalendarController calendarController;
  final VoidCallback onDateSelected;
  const CalenderPopUp(
      {Key key,
      @required this.calendarController,
      @required this.onDateSelected})
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
          TitleText(
            'When is your event?',
            fontSize: 25,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          TableCalendar(
            onDaySelected: (day, events, holidays) {
              setState(() {
                selectedDate = day;
              });
            },
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.grey),
              weekdayStyle: TextStyle(color: Colors.grey),
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: false,
              formatButtonVisible: false,
              headerPadding: EdgeInsets.only(left: 4.0),
              headerMargin: EdgeInsets.symmetric(vertical: 18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
              titleTextStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 22),
              leftChevronIcon: Icon(
                FontAwesomeIcons.caretLeft,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
              rightChevronIcon: Icon(
                FontAwesomeIcons.caretRight,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
            calendarStyle: CalendarStyle(
              contentPadding: EdgeInsets.zero,
              markersColor: Theme.of(context).accentColor,
              selectedColor: Theme.of(context).primaryColor,
              todayColor: Theme.of(context).primaryColor.withOpacity(0.5),
              outsideDaysVisible: false,
              weekendStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
              weekdayStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
            calendarController: widget.calendarController,
          ),
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
