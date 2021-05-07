import 'dart:async';
import 'dart:typed_data';

import 'package:awesome_flutter_widgets/widgets/awesome_buttons.dart';
import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/auth_page.dart';
import 'package:eventz/pages/global_widgets.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class AddEventsPage extends StatefulWidget {
  final DateTime eventDate;
  final bool isPopUp;

  const AddEventsPage({Key key, this.eventDate, this.isPopUp = false})
      : super(key: key);
  @override
  _AddEventsPageState createState() => _AddEventsPageState();
}

class _AddEventsPageState extends State<AddEventsPage> {
  List<Uint8List> postersList = [];
  bool isLoading = false;
  MapController controller;
  bool isOpened = true;
  String location;
  TextEditingController _locationText = TextEditingController();

  void _gotoDefault() {
    controller.center = LatLng(35.68, 51.41);
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
  }

  Offset _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = MapController(
      location: LatLng(35.68, 51.41),
    );
    _gotoDefault();
  }

  @override
  void dispose() {
    postersList.clear();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isPopUp
          ? null
          : AppBar(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 6,
                        child: TitleText(
                          'Create New Event',
                          fontSize: 32,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: ScaleAnimation(
                          child: Image.asset(
                            GlobalValues.addImage,
                            height: 200,
                          ),
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
                hintText: 'Event Subtitle',
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
                        controller: _locationText,
                        maxLines: 1,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  child: CustomPopUp(
                                    body: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: GestureDetector(
                                          onDoubleTap: _onDoubleTap,
                                          onScaleStart: _onScaleStart,
                                          onScaleUpdate: _onScaleUpdate,
                                          onScaleEnd: (details) {
                                            print(
                                                "Location: ${controller.center.latitude}, ${controller.center.longitude}");
                                            setState(() {
                                              location =
                                                  '${controller.center.latitude}, ${controller.center.longitude}';
                                              _locationText.text = location;
                                            });
                                          },
                                          child: Map(
                                            controller: controller,
                                            builder: (context, x, y, z) {
                                              final url =
                                                  'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                                              return CachedNetworkImage(
                                                imageUrl: url,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
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
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
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
              postersList.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(postersList.length, (index) {
                              return Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: MemoryImage(postersList[index]),
                                        fit: BoxFit.cover)),
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AwesomeButton(
                  onPressed: () async {
                    // FilePickerResult result = await FilePicker.platform
                    //     .pickFiles(type: FileType.image);
                    // try {
                    //   File imgFile;
                    //   Uint8List data;
                    //   for (int i = 0; i < result.files.length; i++) {
                    //     imgFile = File(result.files[i].path);
                    //     data = await imgFile.absolute.readAsBytes();
                    //     print(data);
                    //     setState(() {
                    //       postersList.add(data);
                    //     });
                    //   }
                    // } catch (err) {}
                  },
                  icon: Icon(FontAwesomeIcons.fileImage),
                  label: SubtitleText('Add Event Poster'),
                ),
              ),
              widget.isPopUp
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ThemeLoadButton(
                        isLoading: isLoading,
                        child: SubtitleText(
                          'Done',
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          Timer(Duration(seconds: 2), () async {
                            setState(() {
                              isLoading = false;
                            });
                            await showDialog(
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
                                      onDonePressed: () =>
                                          Navigator.pop(context),
                                    ));
                              },
                            );
                          });
                        },
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPopUp extends StatelessWidget {
  final Widget image, body, action;
  final String title;
  final String subtitle;
  final VoidCallback onDonePressed;
  final bool showCancel, showDone;
  final double height;

  const CustomPopUp({
    Key key,
    this.image,
    this.title,
    this.subtitle,
    this.onDonePressed,
    this.showCancel = false,
    this.showDone = true,
    this.height,
    this.body,
    this.action,
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
                padding: body != null
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)
                        .add(EdgeInsets.only(top: 10.0)),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 2.0),
                ),
                child: body ??
                    Column(
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
                ? action ??
                    Container(
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
