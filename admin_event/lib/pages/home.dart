import 'package:admin_event/global_values.dart';
import 'package:admin_event/utils/global_widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(GlobalValues.logoImage),
            TitleText('V5'),
          ],
        ),
      ),
    );
  }
}
