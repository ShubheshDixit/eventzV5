import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/my_web_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key key}) : super(key: key);
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isSaved = false;
  VideoPlayerController _playerController;

  @override
  void initState() {
    _playerController =
        VideoPlayerController.network(GlobalValues.backgroundVideoUrl);
    _playerController.initialize().then((_) {
      setState(() {});
    });

    _playerController.play().then((value) {});
    _playerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
              flexibleSpace: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Stack(
                  children: [
                    Container(
                      height: 400,
                      child: VideoPlayer(_playerController),
                    ),
                    Container(
                      color: Colors.pink[900].withOpacity(0.5),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Image.network(
                              'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2021/08/whiteleterr.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: ScaleAnimation(
                child: Container(
                  margin: EdgeInsets.only(top: 260)
                      .add(EdgeInsets.symmetric(horizontal: 20.0)),
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Form embeded
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          height: MediaQuery.of(context).size.height - 350,
                          child: MyEmbededView(
                            url:
                                'https://fs20.formsite.com/res/showFormEmbed?EParam=m_OmK8apOTC04WXCvcfN1PuzXEr0Q4JDFzpUCZwnDno&519734538&EmbedId=519734538',
                            // javascriptMode: JavascriptMode.unrestricted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
