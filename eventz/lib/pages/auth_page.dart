import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_containers.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: Flex(
        direction: MediaQuery.of(context).orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            // flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: 'LoginImage',
                child: Image.asset(
                  'images/illustrations/Product launch.png',
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
          ),
          AwesomeContainer(
            isActionHidden: true,
            bodyWidget: Column(
              children: [
                TitleText(
                  'Get Started',
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.w900,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
                      .add(
                    EdgeInsets.only(top: 10.0),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Colors.black.withAlpha(60),
                      ),
                    ],
                  ),
                  child: TextButton.icon(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                        (_) => Color(0xfffbafe6).withOpacity(0.2),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.grey[200],
                      ),
                    ),
                    label: Text(
                      'Login with Google',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[200],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 2.0,
                      indent: 15.0,
                      endIndent: 15.0,
                    )),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 2.0,
                      indent: 15.0,
                      endIndent: 15.0,
                    ))
                  ],
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
                      .add(EdgeInsets.only(bottom: 20.0)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 1,
                        color: Colors.black.withAlpha(35),
                      ),
                    ],
                  ),
                  child: TextButton.icon(
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.grey[800],
                      ),
                    ),
                    label: Text(
                      'Login with Email',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AwesomeContainer(
            isContainerScrollable: true,
            overflowChildWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: 'LoginImage',
                child: Image.asset(
                  'images/illustrations/Product launch.png',
                  alignment: Alignment.center,
                ),
              ),
            ),
            containerDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            isActionHidden: true,
            overflowChildHeight: 200,
            overflowChildWidth: 200,
            bodyWidget: Column(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                // AwesomeTextField(
                //   labelText: 'Username',
                //   hintText: 'Enter Username',
                // ),
                AwesomeTextField(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                ),
                AwesomeTextField(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AwesomeButton(
                    isExpanded: true,
                    height: 55,
                    buttonType: AwesomeButtonType.elevated,
                    child: SubtitleText('Log In'),
                    onPressed: () {},
                    buttonStyle: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AwesomeButton(
                    isExpanded: true,
                    height: 55,
                    buttonType: AwesomeButtonType.text,
                    child: SubtitleText('Don\'t have an account? Sign Up'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum LogMode { login, signup }
