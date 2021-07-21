import 'dart:ui';

import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final VoidCallback onMenuPressed;

  const ContactPage({Key key, this.onMenuPressed}) : super(key: key);
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.dark,
            expandedHeight: 300,
            toolbarHeight: 130,
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 0.0,
              title: TitleText(
                'Contact',
                fontSize: 30,
                color: Colors.white,
              ),
              subtitle: SubtitleText(
                'Marketing/Promotion Company based out of Chicago specializing in 21+ Events, Concerts, and Special Events.',
                color: Colors.white,
              ),
            ),
            flexibleSpace: Image.asset(
              GlobalValues.partyImage,
              fit: BoxFit.cover,
              height: 400,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                  decoration: BoxDecoration(
                    // color: Colors.pink,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1.0,
                        blurRadius: 5.0,
                      )
                    ],
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListTile(
                          onTap: () async {
                            launch("tel://773 561 9111");
                          },
                          minLeadingWidth: 0,
                          // tileColor: Colors.pink,
                          title: TitleText('Call Us'),
                          subtitle: SubtitleText(
                            '773 561 9111',
                            // color: Theme.of(context).primaryColor,
                          ),
                          leading: Icon(FontAwesomeIcons.phone),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListTile(
                          onTap: () async {
                            launch("sms://773 561 9111");
                          },
                          minLeadingWidth: 0,
                          // tileColor: Colors.pink,
                          title: TitleText('Text Us'),
                          subtitle: SubtitleText(
                            '773 561 9111',
                            // color: Theme.of(context).primaryColor,
                          ),
                          leading: Icon(FontAwesomeIcons.solidComment),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListTile(
                          onTap: () async {
                            launch(GlobalValues.mailUrl);
                          },
                          minLeadingWidth: 0,
                          title: TitleText('Mail Us'),
                          subtitle: SubtitleText(
                            GlobalValues.mailUrl
                                .replaceAll('mailto:', '')
                                .toLowerCase(),
                            // color: Theme.of(context).primaryColor,
                          ),
                          leading: Icon(FontAwesomeIcons.solidEnvelope),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    // color: Colors.pink,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1.0,
                        blurRadius: 5.0,
                      )
                    ],
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                      width: 3.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Routemaster.of(context).push('webpage',
                                queryParameters: {
                                  'title': 'Spotify',
                                  'url': GlobalValues.spotifyUrl
                                });
                          },
                          icon: Icon(FontAwesomeIcons.spotify),
                          iconSize: 30,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Routemaster.of(context).push('webpage',
                                queryParameters: {
                                  'title': 'SoundCloud',
                                  'url': GlobalValues.soundCloudUrl
                                });
                          },
                          icon: Icon(FontAwesomeIcons.soundcloud),
                          iconSize: 30,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Routemaster.of(context).push('webpage',
                                queryParameters: {
                                  'title': 'Instagram',
                                  'url': GlobalValues.instagramUrl
                                });
                          },
                          icon: Icon(FontAwesomeIcons.instagram),
                          iconSize: 30,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Routemaster.of(context).push('webpage',
                                queryParameters: {
                                  'title': 'Facebook',
                                  'url': GlobalValues.facebookUrl
                                });
                          },
                          icon: Icon(FontAwesomeIcons.facebook),
                          iconSize: 30,
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.black.withOpacity(0.1),
                        //       spreadRadius: 1.0,
                        //       blurRadius: 5.0,
                        //     )
                        //   ],
                        //   borderRadius: BorderRadius.circular(50),
                        //   color: Colors.pink,
                        //   border: Border.all(
                        //     width: 3.0,
                        //     color: Theme.of(context).textTheme.bodyText1.color,
                        //   ),
                        // ),
                        child: IconButton(
                          onPressed: () {
                            Routemaster.of(context).push('webpage',
                                queryParameters: {
                                  'title': 'TikTok',
                                  'url': GlobalValues.tiktokUrl
                                });
                          },
                          icon: Icon(FontAwesomeIcons.tiktok),
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1.0,
                        blurRadius: 5.0,
                      )
                    ],
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      AwesomeTextField(
                        labelText: 'Name',
                        borderType: InputBorderType.none,
                        enabledBorderColor: Colors.grey[700],
                      ),
                      Divider(
                        height: 0,
                      ),
                      AwesomeTextField(
                        labelText: 'Email',
                        borderType: InputBorderType.none,
                        enabledBorderColor: Colors.grey[700],
                      ),
                      Divider(
                        height: 0,
                      ),
                      AwesomeTextField(
                        labelText: 'Mobile',
                        borderType: InputBorderType.none,
                        enabledBorderColor: Colors.grey[700],
                      ),
                      // Divider(),
                      AwesomeButton(
                        onPressed: () {},
                        buttonStyle: ButtonStyle(
                          backgroundColor:
                              MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.disabled))
                              return Colors.grey;
                            return Theme.of(context).textTheme.bodyText1.color;
                          }),
                          shape: MaterialStateProperty.resolveWith((_) =>
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0)))),
                        ),
                        buttonType: AwesomeButtonType.elevated,
                        isExpanded: true,
                        height: 60,
                        child: SubtitleText(
                          'Subscribe to newsletter',
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    // color: Colors.pink,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1.0,
                        blurRadius: 5.0,
                      )
                    ],
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                      width: 3.0,
                    ),
                  ),
                  child: ListTile(
                    onTap: () => Routemaster.of(context)
                        .push('chat/${FirebaseAuth.instance.currentUser.uid}'),
                    minLeadingWidth: 20.0,
                    leading: FaIcon(FontAwesomeIcons.facebookMessenger),
                    title: TitleText('Live Chat 🔥'),
                    subtitle: SubtitleText(
                        'Got any query? Chat with us to resolve your problems.'),
                  ),
                ),
                SizedBox(
                  height: 400,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
