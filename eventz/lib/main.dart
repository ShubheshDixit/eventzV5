import 'dart:io';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/auth_page.dart';
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
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1a1a1a),
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
      home: AuthPage(),
    );
  }
}
