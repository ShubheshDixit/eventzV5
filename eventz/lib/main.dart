import 'package:eventz/global_values.dart';
import 'package:eventz/pages/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        scaffoldBackgroundColor: Colors.grey[900], //Color(0xff060303),
        hintColor: Colors.grey,
        cardColor: GlobalValues.cardColorDark,
        brightness: Brightness.dark,
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: GlobalValues.accentColor,
          actionTextColor: GlobalValues.primaryColor,
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
        scaffoldBackgroundColor: Colors.white,
        cardColor: Color(0xffe2c2d7), //GlobalValues.fontColorLight,
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
      home: IntroPage(),
    );
  }
}
