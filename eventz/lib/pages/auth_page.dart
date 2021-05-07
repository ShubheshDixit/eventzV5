import 'dart:async';
import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/backend/database.dart';
import 'package:eventz/backend/firebase_util.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:eventz/pages/home_page.dart';
import 'package:eventz/pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

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
          if (mounted)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage()));
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
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'PROMOTION',
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'BACHELORETTE',
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'NIGHT OUT',
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'BIRTHDAY',
                                        fontSize: 40,
                                      )),
                                    ),
                                    ScaleAnimation(
                                      child: Center(
                                          child: TitleText(
                                        'LIFE',
                                        fontSize: 40,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              SubtitleText(
                                'WITH US',
                                fontSize: 30,
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
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w900,
              ),
            ),
            FadeAnimation(
              0.4,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubtitleText(
                  'Create your account now and get yourself into the world of joy.',
                  textAlign: TextAlign.center,
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
            !isMobile(context)
                ? Expanded(
                    child: LoginPage(
                      isFull: false,
                    ),
                  )
                : ScaleAnimation(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AwesomeButton(
                      buttonStyle: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
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
    // _controller = VideoPlayerController.asset(GlobalValues.clubVid)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    // _controller.play().then((value) {});
    // _controller.setLooping(true);
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
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isFull ? null : Colors.transparent,
      body: Stack(
        children: [
          Flex(
            direction:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // widget.isFull
              //     ? Expanded(
              //         flex: 1,
              //         child: Hero(
              //           tag: 'LoginVideo',
              //           child: Material(
              //               color: Colors.transparent,
              //               child: _controller.value.isInitialized
              //                   ? VideoPlayer(_controller)
              //                   : Container()),
              //         ),
              //       )
              //     : SizedBox(),
              Expanded(
                flex: 2,
                child: Hero(
                  tag: 'LoginImage',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: widget.isFull
                          ? BoxDecoration(
                              // gradient: LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              //   colors: [
                              //     Color(0xff300a89),
                              //     Colors.purple,
                              //   ],
                              // ),
                              image: DecorationImage(
                                  image: AssetImage(GlobalValues.clubImage),
                                  fit: BoxFit.cover),
                            )
                          : null,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        color: widget.isFull
                            ? Colors.black.withOpacity(0.8)
                            : Colors.transparent,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20.0),
                        child: AnimatedSize(
                          vsync: this,
                          duration: Duration(milliseconds: 300),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              mode == LogMode.signup
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: SubtitleText(
                                        'Username',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              mode == LogMode.signup
                                  ? AwesomeTextField(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.2),
                                      inputStyle: TextStyle(fontSize: 20),
                                      maxLines: 1,
                                      borderType: InputBorderType.none,
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
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                child: SubtitleText(
                                  'Email',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AwesomeTextField(
                                hintText: 'Enter your email',
                                maxLines: 1,
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                borderType: InputBorderType.none,
                                onChanged: (String s) {
                                  setState(() {
                                    email = s;
                                  });
                                },
                                hintStyle: TextStyle(color: Colors.grey),
                                inputStyle: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                child: SubtitleText(
                                  'Password',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AwesomeTextField(
                                hintText: 'Enter your password',
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                maxLines: 1,
                                isPassword: true,
                                onChanged: (String s) {
                                  setState(() {
                                    password = s;
                                  });
                                },
                                borderType: InputBorderType.none,
                                hintStyle: TextStyle(color: Colors.grey),
                                inputStyle: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8.0),
                                child: ThemeLoadButton(
                                  buttonStyle: ButtonStyle(backgroundColor:
                                      MaterialStateColor.resolveWith((states) {
                                    if (states.contains(MaterialState.disabled))
                                      return Colors.grey[500];
                                    else
                                      return Colors.white;
                                  })),
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
                                        ? 'Create Account'
                                        : 'Log In',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: AwesomeButton(
                                  isExpanded: true,
                                  height: 50,
                                  buttonType: AwesomeButtonType.text,
                                  child: SubtitleText(
                                    mode == LogMode.signup
                                        ? 'Already have an account? Log in'
                                        : 'Don\'t have an account? Sign Up',
                                    fontSize: 16,
                                    color: Colors.white,
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
              ),
            ],
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
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
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
                  height: 55,
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
        print(newIndex);
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
