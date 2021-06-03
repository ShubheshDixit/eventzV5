import 'dart:io';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/auth_page.dart';
import 'package:eventz/pages/web/web_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (!kIsWeb)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventz by V5',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xff101010),
        hintColor: Colors.grey,
        cardColor: GlobalValues.cardColorDark,
        brightness: Brightness.dark,
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: GlobalValues.accentColor,
          actionTextColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          headline2: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          headline3: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          headline4: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          headline5: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          headline6: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          subtitle1: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          subtitle2: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          bodyText1: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
          bodyText2: GoogleFonts.poppins(color: GlobalValues.fontColorLight),
        ),
        fontFamily:
            GoogleFonts.poppins(color: GlobalValues.fontColorLight).fontFamily,
        primaryColor: GlobalValues.primaryColor, //Colors.pink,
        accentColor: GlobalValues.accentColor, //Color(0xff61a99b),
        buttonTheme: ButtonThemeData(
          focusColor: GlobalValues.accentColor,
          splashColor: GlobalValues.accentColor,
          highlightColor: GlobalValues.accentColor,
          hoverColor: GlobalValues.accentColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: GlobalValues.accentColor,
          selectionColor: GlobalValues.accentColor,
          selectionHandleColor: GlobalValues.accentColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => GlobalValues.primaryColor,
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => GlobalValues.primaryColor.withOpacity(0.2),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (_) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => GlobalValues.primaryColor,
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => GlobalValues.primaryColor.withOpacity(0.2),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (_) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Colors.grey,
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled)
                      ? Colors.grey
                      : GlobalValues.primaryColor,
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
      ),
      theme: ThemeData(
        fontFamily:
            GoogleFonts.poppins(color: GlobalValues.fontColorDark).fontFamily,
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          headline2: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          headline3: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          headline4: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          headline5: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          headline6: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          subtitle1: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          subtitle2: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          bodyText1: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
          bodyText2: GoogleFonts.poppins(color: GlobalValues.fontColorDark),
        ),
        primaryColor: GlobalValues.primaryColor,
        accentColor: GlobalValues.accentColor,
        scaffoldBackgroundColor: Colors.grey[200],
        cardColor: GlobalValues.cardColorLight,
        hintColor: Colors.grey,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: GlobalValues.accentColor,
          selectionColor: GlobalValues.accentColor,
          selectionHandleColor: GlobalValues.accentColor,
        ),
        buttonTheme: ButtonThemeData(
          focusColor: GlobalValues.accentColor,
          splashColor: GlobalValues.accentColor,
          highlightColor: GlobalValues.accentColor,
          hoverColor: GlobalValues.accentColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Colors.pink,
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Colors.pink.withOpacity(0.2),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Colors.pink,
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Colors.pink.withOpacity(0.2),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (_) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Colors.pink,
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (_) => Colors.pink,
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
      ),
      home: kIsWeb ? WebHome() : AuthPage(),
    );
  }
}

// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:gg_router/gg_router.dart';
// import 'package:gg_value/gg_value.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

// void main() {
//   configureApp();
//   runApp(GgRouterExample());
// }

// const debugShowCheckedModeBanner = false;

// // .............................................................................
// class GgRouterExample extends StatelessWidget {
//   GgRouterExample({Key key}) : super(key: key);

//   // ...........................................................................
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: "GgRouterExample",
//       routerDelegate: GgRouterDelegate(
//         child: _appContent,
//         saveState: _saveState,
//         restoreState: _restoreState,
//         defaultRoute: '/sports/basketball',
//       ),
//       routeInformationParser: GgRouteInformationParser(),
//       themeMode: ThemeMode.dark,
//       darkTheme: ThemeData(brightness: Brightness.dark),
//       theme: ThemeData(brightness: Brightness.light),
//       debugShowCheckedModeBanner: debugShowCheckedModeBanner,
//     );
//   }

//   // ...........................................................................
//   Widget get _appContent {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GgRouter'),
//         actions: <Widget>[
//           _routeButton('Sports', 'sports'),
//           _routeButton('Transportation', 'transportation'),
//           _routeButton('Places', 'places'),
//           Container(
//             width: debugShowCheckedModeBanner ? 50 : 0,
//           ),
//         ],
//       ),
//       body: Builder(
//         builder: (context) {
//           _initErrorHandler(context);
//           return GgRouter(
//             {
//               '_INDEX_': _indexPage,
//               'sports': _sportsPage,
//               'transportation': _transportationPage,
//               'places': _placesPage,
//               '*': _wildCardPage,
//             },
//             key: ValueKey('mainRouter'),
//             inAnimation: _zoomIn,
//             outAnimation: _zoomOut,
//           );
//         },
//       ),
//     );
//   }

//   // ...........................................................................
//   _initErrorHandler(BuildContext context) {
//     final node = GgRouter.of(context).node;
//     node.errorHandler = null;
//     node.errorHandler = (error) {
//       final snackBar = SnackBar(
//         content: Text(error.message),
//         duration: Duration(seconds: 6),
//         backgroundColor: Colors.red,
//       );

//       scheduleMicrotask(
//           () => ScaffoldMessenger.of(context).showSnackBar(snackBar));
//     };
//   }

//   // ...........................................................................
//   Widget _text(String text, BuildContext context, bool isStaged) {
//     final theme = Theme.of(context);
//     final onPrimary = theme.colorScheme.onPrimary;
//     final onPrimaryInactive = onPrimary.withAlpha(120);
//     return Padding(
//       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//       child: Text(
//         text,
//         style: TextStyle(color: isStaged ? onPrimary : onPrimaryInactive),
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _bigIcon(BuildContext context, IconData icon) {
//     return Center(
//       child: Icon(
//         icon,
//         size: 200,
//         color: Color(0x33FFFFFF),
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _routeButton(String title, String route) {
//     return Builder(builder: (context) {
//       final router = GgRouter.of(context);

//       return StreamBuilder(
//         stream: router.onActiveChildChange,
//         builder: (context, snapshot) {
//           final isStaged = router.routeNameOfActiveChild == route;
//           return TextButton(
//             key: ValueKey(route),
//             onPressed: () => router.navigateTo('$route/_LAST_'),
//             child: _text(title, context, isStaged),
//           );
//         },
//       );
//     });
//   }

//   // ...........................................................................
//   Widget _dialog(BuildContext context) {
//     return Dialog(
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//               key: ValueKey('dialogCloseButton'),
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 GgRouter.of(context).navigateTo('..');
//               },
//             ),
//           ),
//           Center(
//             child: Column(
//               children: [
//                 Expanded(child: Container()),
//                 _checkBox(context),
//                 Expanded(child: Container()),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _checkBox(BuildContext context) {
//     final GgValue param = GgRouter.of(context).param('visit');

//     return Row(children: [
//       Expanded(child: Container()),
//       SizedBox(
//         width: 200,
//         height: 50,
//         child: Container(
//           color: Color(0x11FFFFFF),
//           child: StreamBuilder(
//             stream: param.stream,
//             builder: (context, snapshot) {
//               return CheckboxListTile(
//                 title: Text("Visit Event"),
//                 value: param.value,
//                 onChanged: (newValue) => param.value = newValue,
//               );
//             },
//           ),
//         ),
//       ),
//       Expanded(child: Container()),
//     ]);
//   }

//   // ...........................................................................
//   Widget _indexPage(BuildContext context) {
//     return Center(
//       key: ValueKey('indexPage'),
//       child: Text(
//         'GgRouter',
//         style: Theme.of(context).textTheme.headline2,
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _wildCardPage(BuildContext context) {
//     final routeName = GgRouter.of(context).routeName;

//     return Center(
//       key: ValueKey('wildCardPage'),
//       child: Text(
//         'Wildcard: $routeName',
//         key: ValueKey('WildCardText: $routeName'),
//         style: Theme.of(context).textTheme.headline2,
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _sportsPage(BuildContext context) {
//     final router = GgRouter.of(context);

//     return Scaffold(
//       key: ValueKey('sportsPage'),
//       bottomNavigationBar: StreamBuilder(
//           stream: router.onActiveChildChange,
//           builder: (context, snapshot) {
//             final index = router.indexOfActiveChild ?? 0;

//             return BottomNavigationBar(
//               currentIndex: index,
//               items: [
//                 BottomNavigationBarItem(
//                   label: 'Basketball',
//                   icon: Icon(Icons.sports_basketball),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Football',
//                   icon: Icon(Icons.sports_football),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Handball',
//                   icon: Icon(Icons.sports_handball),
//                 ),
//               ],
//               onTap: (index) {
//                 switch (index) {
//                   case 0:
//                     router.navigateTo('basketball/_LAST_');
//                     break;
//                   case 1:
//                     router.navigateTo('football/_LAST_');
//                     break;
//                   case 2:
//                     router.navigateTo('handball/_LAST_');
//                     break;
//                 }
//               },
//             );
//           }),
//       body: GgRouter(
//         {
//           'basketball': (context) {
//             return GgRouteParams(
//               params: {
//                 'visit': GgRouteParam<bool>(seed: false),
//               },
//               child: GgPopoverRoute(
//                 key: ValueKey('dialog'),
//                 name: 'popover',
//                 base: Listener(
//                   child: _bigIcon(context, Icons.sports_basketball),
//                   onPointerUp: (_) =>
//                       GgRouter.of(context).navigateTo('./popover'),
//                 ),
//                 popover: _dialog,
//                 inAnimation: _rotateIn,
//                 outAnimation: _rotateOut,
//               ),
//             );
//           },
//           'football': (c) => _bigIcon(c, Icons.sports_football),
//           'handball': (c) => _bigIcon(c, Icons.sports_handball),
//         },
//         key: ValueKey('sportsRouter'),
//         defaultRoute: 'basketball',
//         inAnimation: _moveIn,
//         outAnimation: _moveOut,
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _transportationPage(BuildContext context) {
//     final router = GgRouter.of(context);

//     return Scaffold(
//       key: ValueKey('transportationPage'),
//       bottomNavigationBar: StreamBuilder(
//           stream: router.onActiveChildChange,
//           builder: (context, snapshot) {
//             final index = router.indexOfActiveChild ?? 0;

//             return BottomNavigationBar(
//               currentIndex: index,
//               items: [
//                 BottomNavigationBarItem(
//                   label: 'Bus',
//                   icon: Icon(Icons.directions_bus),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Bike',
//                   icon: Icon(Icons.directions_bike),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Car',
//                   icon: Icon(Icons.directions_car),
//                 ),
//               ],
//               onTap: (index) {
//                 switch (index) {
//                   case 0:
//                     router.navigateTo('bus');
//                     break;
//                   case 1:
//                     router.navigateTo('bike');
//                     break;
//                   case 2:
//                     router.navigateTo('car');
//                     break;
//                 }
//               },
//             );
//           }),
//       body: GgRouter(
//         {
//           'bus': (c) => _bigIcon(c, Icons.directions_bus),
//           'bike': (c) => _bigIcon(c, Icons.directions_bike),
//           'car': (c) => _bigIcon(c, Icons.directions_car),
//         },
//         key: ValueKey('/transportation'),
//         defaultRoute: 'bus',
//         inAnimation: _moveIn,
//         outAnimation: _moveOut,
//       ),
//     );
//   }

// // ...........................................................................
//   Widget _placesPage(BuildContext context) {
//     final router = GgRouter.of(context);
//     // return Container(color: Colors.green);

//     return Scaffold(
//       bottomNavigationBar: StreamBuilder(
//           key: ValueKey('placesPage'),
//           stream: router.onActiveChildChange,
//           builder: (context, snapshot) {
//             final index = router.indexOfActiveChild ?? 0;

//             return BottomNavigationBar(
//               currentIndex: index,
//               items: [
//                 BottomNavigationBarItem(
//                   label: 'Airpot',
//                   icon: Icon(Icons.airplanemode_active),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Park',
//                   icon: Icon(Icons.park),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'Hospital',
//                   icon: Icon(Icons.local_hospital),
//                 ),
//               ],
//               onTap: (index) {
//                 switch (index) {
//                   case 0:
//                     router.navigateTo('airport');
//                     break;
//                   case 1:
//                     router.navigateTo('park');
//                     break;
//                   case 2:
//                     router.navigateTo('hospital');
//                     break;
//                 }
//               },
//             );
//           }),
//       body: GgRouter(
//         {
//           'airport': (c) => _bigIcon(c, Icons.airplanemode_active),
//           'park': (c) => _bigIcon(c, Icons.park),
//           'hospital': (c) => _bigIcon(c, Icons.local_hospital),
//         },
//         key: ValueKey('/places'),
//         defaultRoute: 'airport',
//         inAnimation: _moveIn,
//         outAnimation: _moveOut,
//       ),
//     );
//   }

//   // ...........................................................................
//   _saveState(String state) async {
//     (await (SharedPreferences.getInstance()))
//         .setString('lastApplicationState', state);
//   }

//   // ...........................................................................
//   Future<String> _restoreState() async {
//     final result = (await (SharedPreferences.getInstance()))
//         .getString('lastApplicationState');
//     return result;
//   }

//   // ...........................................................................
//   Widget _zoomOut(
//     BuildContext context,
//     Animation animation,
//     Widget child,
//   ) {
//     // In the first part of the animation the old widget is faded out
//     final scale = animation.value < 0.5
//         ? Curves.easeInOut.transform(1.0 - (animation.value * 2.0))
//         : 0.0;

//     return Transform.scale(
//       scale: scale,
//       child: child,
//     );
//   }

//   // ...........................................................................
//   Widget _zoomIn(
//     BuildContext context,
//     Animation animation,
//     Widget child,
//   ) {
//     // In the second part of the animation the new widget is faded in
//     final scale = animation.value >= 0.5
//         ? Curves.easeInOut.transform(((animation.value - 0.5) * 2.0))
//         : 0.0;

//     return Transform.scale(
//       scale: scale,
//       child: child,
//     );
//   }

//   // ...........................................................................
//   Widget _moveIn(
//     BuildContext context,
//     Animation animation,
//     Widget child,
//   ) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     final index = GgRouter.of(context).indexOfChildAnimatingIn;

//     final fromLeft = Offset(-w * (1.0 - animation.value), 0);
//     final fromBottom = Offset(0, h * (1.0 - animation.value));
//     final fromRight = Offset(w * (1.0 - animation.value), 0);

//     Offset offset = index == 0
//         ? fromLeft
//         : index == 1
//             ? fromBottom
//             : fromRight;

//     return Transform.translate(
//       offset: offset,
//       child: child,
//     );
//   }

//   // ...........................................................................
//   Widget _moveOut(
//     BuildContext context,
//     Animation animation,
//     Widget child,
//   ) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     final index = GgRouter.of(context).indexOfChildAnimatingOut;

//     final toRight = Offset(w * (animation.value), 0);
//     final toBottom = Offset(0, h * (animation.value));
//     final toLeft = Offset(w * (-animation.value), 0);

//     Offset offset = index == 0
//         ? toLeft
//         : index == 1
//             ? toBottom
//             : toRight;

//     return Transform.translate(
//       offset: offset,
//       child: child,
//     );
//   }

//   // ...........................................................................
//   Widget _rotateIn(
//     BuildContext context,
//     Animation animation,
//     Widget child,
//   ) {
//     final scale = animation.value;
//     final angle = 2 * pi * animation.value;
//     final fade = animation.value;

//     return Transform.scale(
//       scale: scale,
//       child: Transform.rotate(
//         angle: angle,
//         child: Opacity(
//           opacity: fade,
//           child: child,
//         ),
//       ),
//     );
//   }

//   // ...........................................................................
//   Widget _rotateOut(
//     BuildContext context,
//     Animation animation,
//     Widget child,
//   ) {
//     final scale = 1.0 - animation.value;
//     final angle = -2 * pi * animation.value;
//     final fade = 1.0 - animation.value;

//     return Transform.scale(
//       scale: scale,
//       child: Transform.rotate(
//         angle: angle,
//         child: Opacity(
//           opacity: fade,
//           child: child,
//         ),
//       ),
//     );
//   }
// }
