import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:eventz/pages/my_web_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VIPPage extends StatefulWidget {
  @override
  _VIPPageState createState() => _VIPPageState();
}

class _VIPPageState extends State<VIPPage> {
  bool isVip = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            title: TitleText('VIP'),
            // floating: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor
                    ]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor
                    ]),
              ),
              child: ListTile(
                onTap: () {},
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TitleText(
                    isVip ? 'VIP Member' : 'Get VIP Membership',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0).add(
                    EdgeInsets.only(bottom: 8.0),
                  ),
                  child: Text(
                    isVip
                        ? 'Your VIP membership expires soon.'
                        : 'Become a vip member and enjoy special benefits.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                trailing: Image.asset(
                  GlobalValues.crownImage,
                  width: 100,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(15.0),
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: SubtitleText(
                            'What do you get as a VIP?',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: Theme.of(context).accentColor,
                            child: SubtitleText(
                              '1',
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                          title: SubtitleText('Get notified of special events.',
                              fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: Theme.of(context).accentColor,
                            child: SubtitleText(
                              '2',
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                          title: SubtitleText(
                            'Get a chance to be a part of exclusive giveaways and perks.',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: AwesomeButton(
                              buttonType: AwesomeButtonType.elevated,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                              appBar: AppBar(),
                                              body: MyWebView(
                                                title: 'VIP',
                                                url: GlobalValues.vipUrl,
                                              ),
                                            )));
                              },
                              child: SubtitleText(
                                isVip ? 'You are a VIP' : 'Get VIP Now',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: Image.asset(
                        GlobalValues.vipImage,
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ExpandableThemeContainer(
              title: TitleText(
                'Terms and Conditions',
                fontSize: 16,
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      title: SubtitleText(
                          'By providing your mobile number, you agree that V5 Group may send you periodic SMS or MMS messages containing but not limited to important information, updates, deals, and specials.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                          'You will receive up to 16 messages per month.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                          'You may unsubscribe at any time by texting the word STOP to the 8885619111. You may receive a subsequent message confirming your opt-out request.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                          'For help, send the word HELP to 8885619111.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText('Message and data rates may apply.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                        'United States Participating Carriers Include AT&T, T-Mobile®, Verizon Wireless, Sprint, Boost, U.S. Cellular®, MetroPCS®, InterOp, Cellcom, C Spire Wireless, Cricket, Virgin Mobile and others.',
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                          'You agree to notify us of any changes to your mobile number and update your account with us to reflect this change.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                          'Data obtained from you in connection with this SMS service may include your cell phone number, your carrier’s name, and the date, time and content of your messages, as well as other information that you provide. We may use this information to contact you and to provide the services you request from us.'),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            Theme.of(context).textTheme.bodyText1.color,
                      ),
                      title: SubtitleText(
                          'By subscribing or otherwise using the service, you acknowledge and agree that we will have the right to change and/or terminate the service at any time, with or without cause and/or advance notice.'),
                    ),
                    ListTile(
                      title: SubtitleText(
                          'If you have any questions please contact V5 Group at 3126565701.'),
                    ),
                    ListTile(
                      title: TitleText(
                          'Will I be charged for the text messages I receive?'),
                      subtitle: SubtitleText(
                          'Though V5 Group will never charge you for the text messages you receive, depending on your phone plan, you may see some charges from your mobile provider. Please reach out to your wireless provider if you have questions about your text or data plan.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AwesomeButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(),
                                        body: MyWebView(
                                          title: 'Policy',
                                          url:
                                              'https://app2.simpletexting.com/web-forms/privacy-policy/5ad51b8d0a975a4b2f12bff6',
                                        ),
                                      )));
                        },
                        child: SubtitleText(
                          'View Entire Policy',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExpandableThemeContainer extends StatefulWidget {
  final Widget title, body;
  final bool isAlwaysShown;
  final EdgeInsets titlePadding, containerMargin;

  const ExpandableThemeContainer(
      {Key key,
      this.title,
      this.body,
      this.isAlwaysShown = false,
      this.titlePadding,
      this.containerMargin})
      : super(key: key);
  @override
  _ExpandableThemeContainerState createState() =>
      _ExpandableThemeContainerState();
}

class _ExpandableThemeContainerState extends State<ExpandableThemeContainer>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.containerMargin ?? EdgeInsets.all(15.0),
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
          widget.isAlwaysShown
              ? widget.title
              : ListTile(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  contentPadding: widget.titlePadding ??
                      EdgeInsets.symmetric(horizontal: 20.0),
                  title: widget.title,
                  trailing: Icon(isExpanded
                      ? FontAwesomeIcons.angleUp
                      : FontAwesomeIcons.angleDown),
                ),
          AnimatedSize(
            alignment: Alignment.bottomCenter,
            vsync: this,
            duration: Duration(milliseconds: 400),
            child: isExpanded || widget.isAlwaysShown
                ? widget.body ?? SizedBox()
                : SizedBox(),
          )
        ],
      ),
    );
  }
}
