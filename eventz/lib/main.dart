import 'package:eventz/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventz',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xff202020),
        // fontFamily: GoogleFonts.cabin().fontFamily,
        accentColor: Color(0xfffbafe6),
        primaryColor: Color(0xff7c65f7),
        buttonTheme: ButtonThemeData(
          focusColor: Color(0xff7c65f7),
          splashColor: Color(0xff7c65f7),
          highlightColor: Color(0xff7c65f7),
          hoverColor: Color(0xff7c65f7),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Color(0xff7c65f7),
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Color(0xff7c65f7).withOpacity(0.2),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Color(0xff7c65f7),
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (_) => Color(0xff7c65f7),
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
      ),
      theme: ThemeData(
        fontFamily: GoogleFonts.cabin(color: Colors.grey[800]).fontFamily,
        accentColor: Color(0xfffbafe6),
        primaryColor: Color(0xff7c65f7),
        buttonTheme: ButtonThemeData(
          focusColor: Color(0xff7c65f7),
          splashColor: Color(0xff7c65f7),
          highlightColor: Color(0xff7c65f7),
          hoverColor: Color(0xff7c65f7),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (_) => Color(0xff7c65f7),
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (_) => Color(0xff7c65f7).withOpacity(0.2),
            ),
          ),
        ),
      ),
      home: IntroPage(),
    );
  }
}
