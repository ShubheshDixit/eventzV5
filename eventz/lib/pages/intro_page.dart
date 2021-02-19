import 'package:eventz/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  //
  /// Intro page for events
  final page = new PageViewModel(
    pageColor: Colors.redAccent.withOpacity(0.1),
    iconImageAssetPath: 'images/illustrations/Location.png',
    iconColor: null,
    bubbleBackgroundColor: Colors.black,
    body: Text(
      'Find events around the globe and easily book tickets',
    ),
    title: Text('Events', textAlign: TextAlign.center),
    mainImage: Image.asset(
      'images/illustrations/Location.png',
      height: 300.0,
      width: 300.0,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    ),
    titleTextStyle: TextStyle(
        color: Colors.grey[900], fontWeight: FontWeight.w900, fontSize: 35),
    bodyTextStyle: TextStyle(color: Colors.grey[700]),
  );

  /// Intro page for DJ Mix and DJs Hiring as well as spotify playlist.
  final page_2 = new PageViewModel(
    pageColor: Colors.greenAccent.withOpacity(0.1),
    iconImageAssetPath: 'images/illustrations/Please be patient.png',
    iconColor: null,
    bubbleBackgroundColor: Colors.black,
    body: Text(
      'Listen to DJ mixes and Spotify playlist on the way',
    ),
    title: Text('DJ Mixes & Music', textAlign: TextAlign.center),
    mainImage: Image.asset(
      'images/illustrations/Please be patient.png',
      height: 250.0,
      width: 250.0,
      alignment: Alignment.center,
    ),
    titleTextStyle: TextStyle(
        color: Colors.grey[900], fontWeight: FontWeight.w900, fontSize: 35),
    bodyTextStyle: TextStyle(color: Colors.grey[700]),
  );

  /// Intro page for Shopping merchandise.
  final page_3 = new PageViewModel(
    pageColor: Colors.yellowAccent.withOpacity(0.1),
    iconImageAssetPath: 'images/illustrations/Shopping.png',
    iconColor: null,
    bubbleBackgroundColor: Colors.black,
    body: Text(
      'Buy limited gear for the season and VIP membership for exclusive offers',
    ),
    title: Text(
      'Merch & VIP Membership',
      textAlign: TextAlign.center,
    ),
    mainImage: Image.asset(
      'images/illustrations/Shopping.png',
      height: 250.0,
      width: 250.0,
      alignment: Alignment.center,
    ),
    titleTextStyle: TextStyle(
        color: Colors.grey[900], fontSize: 35, fontWeight: FontWeight.w900),
    bodyTextStyle: TextStyle(color: Colors.grey[700]),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IntroViewsFlutter(
          [page, page_2, page_3],
          onTapDoneButton: () async {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AuthPage(),
              ),
            );
          },
          showSkipButton: false,
          columnMainAxisAlignment: MainAxisAlignment.center,
          pageButtonTextStyles:
              new TextStyle(fontSize: 18.0, color: Colors.black),
        ));
  }
}
