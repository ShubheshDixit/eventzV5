import 'dart:async';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/auth_page.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:eventz/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int currentIndex = 0;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.index;
      });
    });
    AuthService().auth.authStateChanges().listen((User user) {
      if (user != null) {
        Timer(
            Duration(milliseconds: 500),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage())));
      }
      Timer(Duration(milliseconds: 800), () {
        if (mounted)
          setState(() {
            isChecked = true;
          });
      });
    });
  }

  Future<void> changePage(index) async {
    _controller.animateTo(index);
    setState(() {
      currentIndex = index;
    });
  }

  Widget buildIntro() {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          PageFlow(
            assetPath: GlobalValues.exploreImage,
            heading: 'Events ',
            description: 'Find events around the globe and easily book tickets',
            index: 0,
            currentIndex: currentIndex,
            onPageChanged: (index) => changePage(index),
            onSkipPressed: () => changePage(2),
          ),
          PageFlow(
            assetPath: GlobalValues.musicImage,
            heading: 'DJ Mixes & Music',
            description: 'Listen to DJ mixes and Spotify playlist on the way',
            index: 1,
            currentIndex: currentIndex,
            onPageChanged: (index) => changePage(index),
            onSkipPressed: () => changePage(2),
          ),
          PageFlow(
            assetPath: GlobalValues.vipImage,
            heading: 'Merch & VIP Membership',
            description:
                'Buy limited gear for the season and VIP membership for exclusive offers',
            index: 2,
            currentIndex: currentIndex,
            onPageChanged: (index) => changePage(index),
            onSkipPressed: () => changePage(2),
            onDonePressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isChecked ? buildIntro() : SplashPage();
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              GlobalValues.logoImage,
              height: 100,
            ),
            TitleText(
              'Musica',
              color: GlobalValues.primaryColor,
            ),
            SubtitleText('is Our Business')
          ],
        ),
      ),
    ));
  }
}

class PageFlow extends StatelessWidget {
  final String assetPath, heading, description;
  final Function(int index) onPageChanged;
  final VoidCallback onDonePressed, onSkipPressed;
  final int currentIndex, index;

  const PageFlow(
      {Key key,
      this.assetPath,
      this.heading,
      this.description,
      this.onPageChanged,
      this.currentIndex,
      this.index,
      this.onDonePressed,
      this.onSkipPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 500,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor),
                    ),
                    onPressed: onSkipPressed,
                    child: SubtitleText(
                      currentIndex != 2 ? 'Skip' : '',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                height: 520,
                child: Stack(
                  children: [
                    Container(
                      height: 500,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)
                              .add(EdgeInsets.only(top: 10.0)),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Theme.of(context)
                                .accentColor, //Theme.of(context).textTheme.bodyText1.color,
                            width: 2.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeAnimation(
                            0.4,
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TitleText(
                                heading,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          FadeAnimation(
                            0.6,
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SubtitleText(
                                description,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FadeAnimation(
                              0.2,
                              Center(
                                child: ScaleAnimation(
                                  repeat: true,
                                  child: Image.asset(
                                    assetPath,
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          onPressed: () {
                            if (index == 2) {
                              onDonePressed();
                            } else
                              onPageChanged(index + 1);
                          },
                          label: currentIndex == 2
                              ? TitleText(
                                  'Done',
                                  fontSize: 18,
                                )
                              : TitleText(
                                  'Next',
                                  fontSize: 18,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        currentIndex == 0
                            ? _buildIndicator(context, 0)
                            : _buildPlaceHolder(context, 0),
                        currentIndex == 1
                            ? _buildIndicator(context, 1)
                            : _buildPlaceHolder(context, 1),
                        currentIndex == 2
                            ? _buildIndicator(context, 2)
                            : _buildPlaceHolder(context, 2)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceHolder(context, index) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => onPageChanged(index),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(context, index) {
    return ScaleAnimation(
      timeDuration: Duration(milliseconds: 1000),
      delay: Duration(microseconds: 1),
      child: InkWell(
        onTap: () => onPageChanged(index),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 15,
            width: 35,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 1),
                    spreadRadius: 2,
                    blurRadius: 5)
              ],
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(500),
            ),
          ),
        ),
      ),
    );
  }
}
