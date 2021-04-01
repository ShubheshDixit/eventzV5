import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddEventsPage extends StatefulWidget {
  final DateTime eventDate;

  const AddEventsPage({Key key, this.eventDate}) : super(key: key);
  @override
  _AddEventsPageState createState() => _AddEventsPageState();
}

class _AddEventsPageState extends State<AddEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeAnimation(
                0.2,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: TitleText(
                          'Create New Event',
                          fontSize: 32,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: ScaleAnimation(
                          child: Image.asset(GlobalValues.addImage),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FadeAnimation(
                0.4,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(2, 5),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleText('Event Date'),
                              SubtitleText('Edit')
                            ],
                          ),
                        ),
                        AwesomeButton(
                          height: 50,
                          onPressed: () {},
                          buttonType: AwesomeButtonType.elevated,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SubtitleText(
                                DateFormat('dd MMMM, yyyy')
                                    .format(widget.eventDate),
                                color: Colors.white,
                              ),
                              Icon(
                                FontAwesomeIcons.calendarAlt,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              AwesomeTextField(
                animationAxis: Axis.vertical,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.3),
                hintText: 'Event Title',
                borderType: InputBorderType.none,
              ),
              AwesomeTextField(
                animationAxis: Axis.vertical,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.3),
                maxLines: 5,
                hintText: 'Event Description',
                borderType: InputBorderType.none,
              ),
              FadeAnimation(
                0.2,
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: AwesomeTextField(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.3),
                        hintText: 'Event Venue',
                        suffix: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Icon(FontAwesomeIcons.mapMarkerAlt),
                        ),
                        borderType: InputBorderType.none,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AwesomeTextField(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.3),
                        hintText: 'Price',
                        prefixIconConstraints: BoxConstraints(minHeight: 0.0),
                        prefixIcon: TitleText(
                          '\$',
                          fontSize: 22,
                          color: Theme.of(context).accentColor,
                        ),
                        borderType: InputBorderType.none,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AwesomeButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.fileImage),
                  label: SubtitleText('Add Event Poster'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AwesomeButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            backgroundColor: Colors.transparent,
                            child: CustomPopUp(
                              title: 'Event Created Successfully!',
                              subtitle:
                                  'Go to \'My Events\' page to find your events and edit or invite people.',
                              image: Image.asset(
                                GlobalValues.sucessImage,
                                height: 250,
                                width: 250,
                              ),
                              onDonePressed: () => Navigator.pop(context),
                            ));
                      },
                    );
                  },
                  height: 50,
                  isExpanded: true,
                  buttonType: AwesomeButtonType.elevated,
                  child: SubtitleText(
                    'Done',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPopUp extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final VoidCallback onDonePressed;
  final bool showCancel, showDone;
  final double height;

  const CustomPopUp({
    Key key,
    @required this.image,
    @required this.title,
    @required this.subtitle,
    this.onDonePressed,
    this.showCancel = false,
    this.showDone = true,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      timeDuration: Duration(milliseconds: 1800),
      child: Container(
        height: !showDone
            ? height != null
                ? (height + 40)
                : 460
            : height != null
                ? (height + 60)
                : 480,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: !showDone
                    ? height ?? 420
                    : height != null
                        ? (height + 20)
                        : 440,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)
                    .add(EdgeInsets.only(top: 10.0)),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 2.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      0.2,
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TitleText(
                          title,
                          fontSize: 24,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.3,
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SubtitleText(
                          subtitle,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ScaleAnimation(
                            delay: Duration(milliseconds: 800),
                            repeat: true,
                            child: image),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            ),
            showCancel
                ? Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 28.0, left: 18.0),
                      child: FloatingActionButton(
                        heroTag: 'close_btn',
                        backgroundColor: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(FontAwesomeIcons.times),
                      ),
                    ),
                  )
                : SizedBox(),
            showDone
                ? Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton.extended(
                        heroTag: 'done_btn',
                        backgroundColor: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: TitleText(
                          'Done',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
