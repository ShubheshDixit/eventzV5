import 'dart:async';

import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_containers.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/backend/firebase_util.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:eventz/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Flex(
          direction: MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: 'LoginImage',
                  child: Material(
                    color: Colors.transparent,
                    child: ScaleAnimation(
                      // duration: 1,
                      repeat: true,
                      child: Image.asset(
                        GlobalValues.authImage,
                        alignment: Alignment.center,
                        // width: 500,
                      ),
                    ),
                  ),
                ),
              ),
              // translateYBegin: 0.0,
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return FadeAnimation(
      0.5,
      Container(
        width: MediaQuery.of(context).size.width > 500
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(
                'Get Started',
                fontSize: 30,
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w900,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubtitleText(
                  'Create your account now and get yourself into the world of joy.',
                  textAlign: TextAlign.center,
                ),
              ),
              ScaleAnimation(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AwesomeButton(
                    buttonType: AwesomeButtonType.elevated,
                    isExpanded: true,
                    height: 55,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.grey[200],
                        size: 22,
                      ),
                    ),
                    label: Text(
                      'Login with Google',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[200],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1.0,
                    indent: 25.0,
                    endIndent: 15.0,
                    color: Theme.of(context).accentColor.withOpacity(0.5),
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
                    thickness: 1.0,
                    indent: 15.0,
                    endIndent: 25.0,
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                  ))
                ],
              ),
              ScaleAnimation(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AwesomeButton(
                  buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).accentColor),
                  ),
                  isExpanded: true,
                  height: 55,
                  buttonType: AwesomeButtonType.elevated,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Colors.grey[900],
                      size: 22,
                    ),
                  ),
                  label: Text(
                    'Login with Email',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LogMode mode = LogMode.login;
  bool isLoading = false;
  String username = "", email = "", password = "";

  bool validate() {
    if (mode == LogMode.login) {
      if (email.length > 3 && password.length > 3)
        return true;
      else
        return false;
    } else {
      if (email.length > 3 && password.length > 3 && username.length > 3)
        return true;
      else
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AwesomeContainer(
            isContainerScrollable: true,
            overflowChildWidget: Hero(
              tag: 'LoginImage',
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Image.asset(
                  GlobalValues.authImage,
                  alignment: Alignment.center,
                ),
              ),
            ),
            containerDecoration: BoxDecoration(
                // color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Theme.of(context).accentColor,
                  width: 2.0,
                )),
            isActionHidden: true,
            overflowChildHeight: 200,
            overflowChildWidth: 200,
            bodyWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    mode == LogMode.signup
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SubtitleText(
                              'Username',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox.shrink(),
                    mode == LogMode.signup
                        ? AwesomeTextField(
                            inputStyle: TextStyle(fontSize: 20),
                            maxLines: 1,
                            borderType: InputBorderType.underlined,
                            hintText: 'Enter your name',
                            onChanged: (String s) {
                              setState(() {
                                username = s;
                              });
                            },
                            hintStyle: TextStyle(color: Colors.grey),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: SubtitleText(
                        'Email',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AwesomeTextField(
                      hintText: 'Enter your email',
                      maxLines: 1,
                      borderType: InputBorderType.underlined,
                      onChanged: (String s) {
                        setState(() {
                          email = s;
                        });
                      },
                      hintStyle: TextStyle(color: Colors.grey),
                      inputStyle: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: SubtitleText(
                        'Password',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AwesomeTextField(
                      hintText: 'Enter your password',
                      maxLines: 1,
                      isPassword: true,
                      onChanged: (String s) {
                        setState(() {
                          password = s;
                        });
                      },
                      borderType: InputBorderType.underlined,
                      hintStyle: TextStyle(color: Colors.grey),
                      inputStyle: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8.0),
                      child: ThemeLoadButton(
                        isLoading: isLoading,
                        onPressed: validate()
                            ? () async {
                                if (mode == LogMode.login) {
                                  await _startSignIn(true);
                                } else {
                                  await _startSignIn(false);
                                }
                              }
                            : null,
                        child: SubtitleText(
                          mode == LogMode.signup ? 'Create Account' : 'Log In',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: AwesomeButton(
                        isExpanded: true,
                        height: 50,
                        buttonType: AwesomeButtonType.text,
                        child: SubtitleText(
                          mode == LogMode.signup
                              ? 'Already have an account? Log in'
                              : 'Don\'t have an account? Sign Up',
                          fontSize: 16,
                        ),
                        onPressed: () {
                          setState(() {
                            if (mode == LogMode.signup)
                              setState(() {
                                mode = LogMode.login;
                              });
                            else
                              setState(() {
                                mode = LogMode.signup;
                              });
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startSignIn(inMode) async {
    setState(() {
      isLoading = true;
    });
    if (inMode) {
      try {
        await AuthService().signInEmail(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Welcome ${AuthService().auth.currentUser.displayName}')));
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.message)));
        return;
      }
    } else {
      try {
        await AuthService()
            .signUpUser(email: email, password: password, name: username);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Welcome ${AuthService().auth.currentUser.displayName}')));
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.message)));
        return;
      }
    }
    User user = AuthService().auth.currentUser;
    await FirebaseUtil().addUserToFirebase(user);
    setState(() {
      isLoading = false;
    });

    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}

enum LogMode { login, signup }

class ThemeLoadButton extends StatefulWidget {
  final Widget child, doneChild;
  final bool isLoading, isDone;
  final VoidCallback onPressed;

  const ThemeLoadButton(
      {Key key,
      @required this.child,
      this.isLoading = false,
      this.doneChild,
      this.isDone,
      @required this.onPressed})
      : assert(!(isDone != null && doneChild == null), ''),
        super(key: key);
  @override
  _ThemeLoadButtonState createState() => _ThemeLoadButtonState();
}

class _ThemeLoadButtonState extends State<ThemeLoadButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        vsync: this,
        duration: Duration(milliseconds: 500),
        child: widget.isLoading
            ? ScaleAnimation(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : ScaleAnimation(
                child: AwesomeButton(
                  isExpanded: !widget.isLoading,
                  height: 50,
                  buttonType: AwesomeButtonType.elevated,
                  child: widget.child,
                  onPressed: widget.onPressed,
                ),
              ),
      ),
    );
  }
}
