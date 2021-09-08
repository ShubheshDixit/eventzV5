import 'dart:io';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/auth_page.dart';
import 'package:eventz/pages/booking_page.dart';
import 'package:eventz/pages/chat_page.dart';
import 'package:eventz/pages/contact_page.dart';
import 'package:eventz/pages/events_details.dart';
import 'package:eventz/pages/home_page.dart';
import 'package:eventz/pages/music_page.dart';
import 'package:eventz/pages/my_web_view.dart';
import 'package:eventz/pages/search_page.dart';
import 'package:eventz/pages/store_page.dart';
import 'package:eventz/pages/tickets_page.dart';
import 'package:eventz/pages/vip_page.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:eventz/.env.dart';

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
  // Stripe.publishableKey = stripePublishableKey;
  StripePayment.setOptions(StripeOptions(
    publishableKey: stripePublishableKey,
    androidPayMode: 'test',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: RoutemasterParser(),
      title: 'Eventz by V5',
      themeMode: ThemeMode.dark,
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
    );
  }
}

final routes = RouteMap(routes: {
  '/': (_) => FirebaseAuth.instance.currentUser != null
      ? MaterialPage(child: HomePage())
      : MaterialPage(child: AuthPage()),
  '/auth': (_) => MaterialPage(child: AuthPage()),
  '/login': (_) => MaterialPage(child: LoginPage()),
  '/home': (_) => MaterialPage(child: HomePage()),
  '/store': (_) => MaterialPage(child: StorePage()),
  '/contact': (_) => MaterialPage(child: ContactPage()),
  '/music': (_) => MaterialPage(child: MusicPage()),
  '/search': (_) => MaterialPage(child: SearchPage()),
  '/tickets': (_) => MaterialPage(child: TicketsPage()),
  '/gallery': (_) => MaterialPage(
        child: Scaffold(
          appBar: AppBar(
            title: TitleText('Gallery'),
          ),
          body:
              MyWebView(title: 'Gallery', url: 'https://v5group.smugmug.com/'),
        ),
      ),
  '/photobooth': (_) => MaterialPage(
        child: Scaffold(
          appBar: AppBar(
            title: TitleText('PhotoBooth'),
          ),
          body: MyWebView(
              title: 'BoothPics',
              url:
                  'https://app.photoboothsupplyco.com/portfolio-embed/7a1ee0dc-6774-5645-b7bc-f5432a06d691/'),
        ),
      ),
  '/vip': (_) => MaterialPage(child: VIPPage()),
  '/booking': (_) => MaterialPage(child: BookingPage()),
  '/home/event/:id': (routes) =>
      MaterialPage(child: EventDetails(eventId: routes.pathParameters['id'])),
  '/contact/webpage': (routes) => MaterialPage(
        child: Scaffold(
          appBar: AppBar(
            title: TitleText(routes.queryParameters['title']),
          ),
          body: MyWebView(url: routes.queryParameters['url']),
        ),
      ),
  '/contact/chat/:id': (routes) => MaterialPage(
          child: ChatPage(
        chatId: routes.pathParameters['id'],
      ))
});
