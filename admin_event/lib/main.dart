import 'package:admin_event/pages/auth_page.dart';
import 'package:admin_event/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: RoutemasterParser(),
      title: 'V5 - Dashboard',
      theme: ThemeData(
        primaryColor: Colors.pink.shade300,
        hintColor: Colors.grey,
      ),
    );
  }
}

final routes = RouteMap(routes: {
  '/': (_) => FirebaseAuth.instance.currentUser != null
      ? MaterialPage(child: HomePage())
      : MaterialPage(child: AuthPage()),
  '/login': (_) => MaterialPage(child: LoginPage()),
  '/home': (_) => MaterialPage(child: HomePage())
});
