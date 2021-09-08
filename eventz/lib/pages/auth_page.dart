import 'dart:async';
import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/backend/firebase_util.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:eventz/pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routemaster/routemaster.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    AuthService().auth.authStateChanges().listen((User user) {
      if (user != null) {
        Timer(Duration(milliseconds: 500), () {
          if (mounted) Routemaster.of(context).replace('/');
        });
      }
      Timer(Duration(milliseconds: 800), () {
        if (mounted)
          setState(() {
            isChecked = true;
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isChecked
        ? SplashPage()
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Flex(
                direction:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          child: Hero(
                            tag: 'LoginImage',
                            child: Material(
                              color: Colors.transparent,
                              child: Image.asset(
                                GlobalValues.clubImage,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SubtitleText(
                                'CELEBRATE YOUR',
                                color: Colors.white,
                                fontSize: 30,
                              ),
                              SizedBox(
                                height: 60,
                                width: 330,
                                child: SlidingTabs(
                                  children: [
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'GRADUATION',
                                        color: Colors.white,
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'PROMOTION',
                                        color: Colors.white,
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'BACHELORETTE',
                                        color: Colors.white,
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'NIGHT OUT',
                                        fontSize: 40,
                                        color: Colors.white,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'BIRTHDAY',
                                        color: Colors.white,
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'LIFE',
                                        fontSize: 40,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              SubtitleText(
                                'WITH US',
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildButtons(),
                ],
              ),
            ),
          );
  }

  Widget _buildButtons() {
    return Container(
      // margin: EdgeInsets.only(top: 15.0),
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width > 500 &&
              MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.width * 0.4
          : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Colors.pink,
            // Color(0xff0b051e),
            Color(0xff300a89),
            Colors.purple,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeAnimation(
              0.2,
              TitleText(
                'Get Started',
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            FadeAnimation(
              0.4,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubtitleText(
                  'Create your account now and get yourself into the world of joy.',
                  textAlign: TextAlign.center,
                  color: Colors.white,
                ),
              ),
            ),
            ScaleAnimation(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AwesomeButton(
                  buttonType: AwesomeButtonType.elevated,
                  isExpanded: true,
                  height: 55,
                  buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey[100],
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.google,
                      // color: Colors.grey[200],
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                  label: Text(
                    'Login with Google',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      // color: Colors.grey[200],
                      color: Colors.black,
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
                  color: Colors.white.withOpacity(0.5),
                )),
                Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: Divider(
                  thickness: 1.0,
                  indent: 15.0,
                  endIndent: 25.0,
                  color: Colors.white.withOpacity(0.5),
                ))
              ],
            ),
            ScaleAnimation(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AwesomeButton(
                buttonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.black),
                ),
                isExpanded: true,
                height: 55,
                buttonType: AwesomeButtonType.elevated,
                onPressed: () async {
                  Routemaster.of(context).push('/login');
                },
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.solidEnvelope,
                    color: Colors.grey[100],
                    size: 22,
                  ),
                ),
                label: Text(
                  'Login with Email',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[100],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final bool isFull;

  const LoginPage({Key key, this.isFull = true}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  // VideoPlayerController _controller;
  LogMode mode = LogMode.login;
  bool isLoading = false;
  String username = "", email = "", password = "";

  @override
  void initState() {
    super.initState();
  }

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
      backgroundColor: widget.isFull ? null : Colors.transparent,
      body: Stack(
        children: [
          Container(
            // color: Theme.of(context).scaffoldBackgroundColor,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Colors.pink,
                  Color(0xff0b051e),
                  Color(0xff300a89),
                  Colors.purple,
                ],
              ),
            ),
          ),
          Center(
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        // backgroundColor: Colors.pink,
                        child: Image.asset(
                          GlobalValues.logoImage,
                          height: 150,
                        ),
                      ),
                      TitleText(
                        'Musica',
                        color: Theme.of(context).primaryColor,
                        fontSize: 33,
                      ),
                      SubtitleText(
                        'is Our Business',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    width: 500,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 500),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TitleText(
                                mode == LogMode.signup ? 'Welcome' : 'Hello',
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TitleText(
                                mode == LogMode.signup
                                    ? 'Create account'
                                    : 'Sign in to your account',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            mode == LogMode.signup
                                ? AwesomeTextField(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50),
                                    inputStyle: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    maxLines: 1,
                                    prefixIconConstraints:
                                        BoxConstraints(maxWidth: 55),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FaIcon(FontAwesomeIcons.solidUser),
                                    ),
                                    borderType: InputBorderType.none,
                                    hintText: 'Enter your name',
                                    labelText: 'User Name',
                                    onChanged: (String s) {
                                      setState(() {
                                        username = s;
                                      });
                                    },
                                    hintStyle: TextStyle(color: Colors.grey),
                                  )
                                : SizedBox.shrink(),
                            AwesomeTextField(
                              backgroundColor: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50),
                              hintText: 'Enter your email',
                              labelText: 'Email ID',
                              prefixIconConstraints:
                                  BoxConstraints(maxWidth: 55),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.solidEnvelope),
                              ),
                              maxLines: 1,
                              borderType: InputBorderType.none,
                              onChanged: (String s) {
                                setState(() {
                                  email = s;
                                });
                              },
                              hintStyle: TextStyle(color: Colors.grey),
                              inputStyle:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            AwesomeTextField(
                              backgroundColor: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50),
                              labelText: 'Password',
                              prefixIconConstraints:
                                  BoxConstraints(maxWidth: 55),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.lock),
                              ),
                              hintText: 'Enter password',
                              maxLines: 1,
                              isPassword: true,
                              onChanged: (String s) {
                                setState(() {
                                  password = s;
                                });
                              },
                              borderType: InputBorderType.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              inputStyle:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8.0),
                              child: ThemeLoadButton(
                                buttonStyle: ButtonStyle(
                                  shape: MaterialStateProperty.resolveWith(
                                    (_) => RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(500.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) {
                                    if (states.contains(MaterialState.disabled))
                                      return Colors.grey[500];
                                    else
                                      return Theme.of(context).primaryColor;
                                  }),
                                ),
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
                                  mode == LogMode.signup
                                      ? 'Register Now'
                                      : 'Login',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: SubtitleText(
                            //     'Or ${mode == LogMode.signup ? 'Register' : 'Login'} with social Media',
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 30.0, vertical: 8.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       IconButton(
                            //         iconSize: 35,
                            //         onPressed: () {},
                            //         icon: Icon(
                            //           FontAwesomeIcons.googlePlus,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //       IconButton(
                            //         iconSize: 35,
                            //         onPressed: () {},
                            //         icon: Icon(
                            //           FontAwesomeIcons.facebook,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //       IconButton(
                            //         iconSize: 33,
                            //         onPressed: () {},
                            //         icon: Icon(
                            //           FontAwesomeIcons.twitter,
                            //           color: Colors.white,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AwesomeButton(
                                isExpanded: true,
                                height: 50,
                                buttonType: AwesomeButtonType.text,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SubtitleText(
                                      mode == LogMode.signup
                                          ? 'Already have an account? '
                                          : 'Don\'t have an account? ',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[300],
                                    ),
                                    SubtitleText(
                                      mode == LogMode.signup
                                          ? 'Log In'
                                          : 'Register',
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        showSnackBar(context,
            Text('Welcome ${AuthService().auth.currentUser.displayName}'));
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, Text(err.message));
        return;
      }
    } else {
      try {
        await AuthService()
            .signUpUser(email: email, password: password, name: username);
        showSnackBar(context,
            Text('Welcome ${AuthService().auth.currentUser.displayName}'));
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, Text(err.message));
        return;
      }
    }
    User user = AuthService().auth.currentUser;
    await FirebaseUtil().addUserToFirebase(user);
    if (mounted)
      setState(() {
        isLoading = false;
      });
    if (mounted) Routemaster.of(context).replace('/home');
  }
}

enum LogMode { login, signup }

class ThemeLoadButton extends StatefulWidget {
  final Widget child, doneChild;
  final bool isLoading, isDone;
  final VoidCallback onPressed;
  final ButtonStyle buttonStyle;

  const ThemeLoadButton(
      {Key key,
      @required this.child,
      this.isLoading = false,
      this.doneChild,
      this.isDone,
      @required this.onPressed,
      this.buttonStyle})
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
                  height: 60,
                  buttonType: AwesomeButtonType.elevated,
                  child: widget.child,
                  onPressed: widget.onPressed,
                  buttonStyle: widget.buttonStyle,
                ),
              ),
      ),
    );
  }
}

class SlidingTabs extends StatefulWidget {
  final List<Widget> children;
  final Duration delay;

  const SlidingTabs({Key key, @required this.children, this.delay})
      : super(key: key);
  @override
  _SlidingTabsState createState() => _SlidingTabsState();
}

class _SlidingTabsState extends State<SlidingTabs>
    with TickerProviderStateMixin {
  TabController _controller;
  int index = 0;
  Timer timerG;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.children.length, vsync: this);

    Timer.periodic(widget.delay ?? Duration(milliseconds: 2000), (timer) {
      try {
        setState(() {
          timerG = timer;
        });
        int newIndex = index == widget.children.length - 1 ? 0 : index + 1;
        setState(() {
          index = newIndex;
        });
        changePage(newIndex);
      } catch (err) {}
    });
  }

  void changePage(index) {
    _controller.animateTo(index,
        curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    try {
      timerG.cancel();
      _controller.dispose();
    } catch (err) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: widget.children,
      controller: _controller,
    );
  }
}
