import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/events_home_page.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';

class WebHome extends StatefulWidget {
  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> with TickerProviderStateMixin {
  TabController _controller, _tabController;
  bool index = false;
  int pageIndex = 0;
  List<String> backImages = [
    'images/illustrations/back_1.jpeg',
    'images/illustrations/back_2.jpeg',
    'images/illustrations/back_3.jpeg'
  ];
  String boothPicUrl =
      'https://app.photoboothsupplyco.com/portfolio-embed/7a1ee0dc-6774-5645-b7bc-f5432a06d691/';
  String galleryPic = 'https://v5group.smugmug.com/';
  String storiesUrl =
      'https://widget.taggbox.com/widget/index.html?wall_id=54746';
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    _tabController = TabController(vsync: this, length: 3);
    // Timer(Duration(seconds: 3), () {
    //   Timer.periodic(Duration(seconds: 5), (timer) {
    //     if (mounted)
    //       setState(() {
    //         index = !index;
    //       });
    //     _controller.animateTo(index ? 1 : 0,
    //         duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            GlobalValues.clubImage,
                          ))),
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Stack(
                      children: [
                        Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(1000),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).accentColor,
                                Theme.of(context).primaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 200),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleText(
                                        'Find The Amazing Events Near You',
                                        fontSize: 40,
                                        shadows: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20.0,
                                        ),
                                        child: Container(
                                          height: 70,
                                          child: TabBarView(
                                            controller: _controller,
                                            children: [
                                              ScaleAnimation(
                                                duration: 1,
                                                child: Material(
                                                    elevation: 0.0,
                                                    color: Colors.transparent,
                                                    child:
                                                        MusicBar()), //SearchBar(),
                                              ),
                                              ScaleAnimation(
                                                duration: 1,
                                                child: Hero(
                                                  tag: 'search_text_bar',
                                                  child: Material(
                                                      elevation: 0.0,
                                                      color: Colors.transparent,
                                                      child: SearchBar()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 200,
                                width: 500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 200, vertical: 50),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            GlobalValues.logoImage,
                            height: 60,
                            width: 60,
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
                      Row(
                        children: [
                          NavButton(
                            text: 'Events',
                            onPressed: () {},
                          ),
                          NavButton(
                            text: 'Gallery',
                            onPressed: () {},
                          ),
                          NavButton(
                            text: 'PhotoBooth',
                            onPressed: () {},
                          ),
                          NavButton(
                            text: 'Events',
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: FadeAnimation(
              0.4,
              Container(
                height: 550,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //   image: AssetImage(backImages[pageIndex]),
                //   fit: BoxFit.cover,
                // )),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 2,
                                    width: 50,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                TitleText(
                                  'Our Events',
                                  fontSize: 30,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 200, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NavButton(
                                    backColor: pageIndex == 0
                                        ? Colors.pink
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        pageIndex = 0;
                                        _tabController.animateTo(0);
                                      });
                                    },
                                    text: 'Weekly',
                                  ),
                                  NavButton(
                                    backColor: pageIndex == 1
                                        ? Colors.pink
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        pageIndex = 1;
                                        _tabController.animateTo(1);
                                      });
                                    },
                                    text: 'Popular',
                                  ),
                                  NavButton(
                                    backColor: pageIndex == 2
                                        ? Colors.pink
                                        : Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        pageIndex = 2;
                                        _tabController.animateTo(2);
                                      });
                                    },
                                    text: 'Tonight',
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 200.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TitleText(
                                        'Weekly Events',
                                        fontSize: 30,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      SubtitleText(
                                        'Find out the best events occuuring every week.',
                                        fontSize: 20,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: EventsTabView(
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 200.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TitleText(
                                        'Popular Events',
                                        fontSize: 30,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      SubtitleText(
                                        'Find out the most popular events around your area.',
                                        fontSize: 20,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: PopularEvents(
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 200.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TitleText(
                                        'Happening Tonight',
                                        fontSize: 30,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      SubtitleText(
                                        'Find out the events happening tonight around your area.',
                                        fontSize: 20,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: EventsTabView(
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
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

class NavButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color backColor, textColor;
  @required
  final String text;

  const NavButton(
      {Key key,
      @required this.onPressed,
      @required this.text,
      this.backColor,
      this.textColor})
      : super(key: key);
  @override
  _NavButtonState createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AwesomeButton(
        onPressed: widget.onPressed,
        buttonStyle: ButtonStyle(
            side: MaterialStateProperty.resolveWith(
                (states) => BorderSide(color: Colors.white, width: 2.0)),
            shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => widget.backColor ?? Colors.grey.withOpacity(0.6))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
          child: TitleText(
            widget.text,
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
