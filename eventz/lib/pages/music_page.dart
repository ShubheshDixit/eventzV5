import 'package:eventz/animations/fade_animations.dart';
import 'package:eventz/animations/scale_animation.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage>
    with SingleTickerProviderStateMixin {
  int currenIndex = 0;
  bool isExpanded = false;
  bool isPlaying = false;
  AnimationController _animationController;
  List<String> _albumList = [
    'images/posters/nano.jpeg',
    'images/posters/baila.jpeg',
    'images/posters/jazz.jpg',
    'images/posters/luxur.jpeg',
    'images/posters/magic.jpg',
    'images/posters/summer.jpg',
    'images/posters/joy.jpeg',
    'images/posters/rock.jpg',
    'images/posters/wicked.jpg',
    'images/posters/2e12d039f260ddcc0cad2674e8570c2a.jpg',
  ];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return !isMobile(context)
    //     ? ExpandableThemeContainer(
    //         isAlwaysShown: true,
    //         title: ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
    //           title: TitleText('V5 Mixes'),
    //           subtitle: SubtitleText(
    //             'Listen to Mixes from our DJs',
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         body: Container(
    //           height: MediaQuery.of(context).size.height * 0.9,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Flexible(
    //                 child: !isMobile(context)
    //                     ? Column(
    //                         children: buildMusicList(),
    //                       )
    //                     : Row(
    //                         mainAxisSize: MainAxisSize.max,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: buildMusicList(),
    //                       ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    return Scaffold(
      appBar: !isMobile(context)
          ? null
          : AppBar(
              title: TitleText('Mixes'),
            ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90.0),
            child: Column(
              children: [
                Flexible(
                  child: !isMobile(context)
                      ? Column(
                          children: buildMusicList(),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildMusicList(),
                        ),
                ),
              ],
            ),
          ),
          !isMobile(context)
              ? SizedBox()
              : DraggableScrollableSheet(
                  initialChildSize: 0.15,
                  minChildSize: 0.15,
                  maxChildSize: 0.8,
                  builder: (context, scrollController) {
                    try {
                      if (scrollController.position.viewportDimension > 400)
                        setState(() {
                          isExpanded = true;
                        });
                      else {
                        setState(() {
                          isExpanded = false;
                        });
                      }
                    } catch (err) {}

                    return Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5.0,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          )),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(5.0).add(
                                  EdgeInsets.only(top: 10.0),
                                ),
                                child: Container(
                                  width: 40,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: GlobalValues.primaryColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {},
                              ),
                              title: TitleText(isExpanded
                                  ? 'Now Playing'
                                  : 'Kids See Ghosts'),
                              subtitle: isExpanded
                                  ? null
                                  : SubtitleText('Kanye West'),
                              trailing: isExpanded
                                  ? null
                                  : FloatingActionButton(
                                      heroTag: 'music_play_bottom',
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: AnimatedIcon(
                                        icon: AnimatedIcons.play_pause,
                                        progress: _animationController,
                                      ),
                                      onPressed: () {
                                        if (isPlaying) {
                                          setState(() {
                                            isPlaying = !isPlaying;
                                          });
                                          _animationController.reverse();
                                        } else {
                                          _animationController.forward();
                                          setState(() {
                                            isPlaying = !isPlaying;
                                          });
                                        }
                                      },
                                    ),
                            ),
                            isExpanded
                                ? SizedBox.shrink()
                                : SizedBox(height: 20),
                            FadeAnimation(
                              1,
                              NowPlaying(
                                imagePath: _albumList[currenIndex],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
        ],
      ),
    );
  }

  List<Widget> buildMusicList() {
    return [
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: !isMobile(context)
            ? null
            : BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5.0,
                )
              ]),
        child: SingleChildScrollView(
          scrollDirection: isMobile(context) ? Axis.vertical : Axis.horizontal,
          child: Flex(
            direction: isMobile(context) ? Axis.vertical : Axis.horizontal,
            children: List.generate(
                10,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: !isMobile(context) ? 8.0 : 0.0),
                      child: MusicProfileImage(
                        imagePath: _albumList[index],
                        isSelected: currenIndex == index,
                        onTap: () {
                          setState(() {
                            currenIndex = index;
                          });
                        },
                      ),
                    )),
          ),
        ),
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0)
                  .add(EdgeInsets.only(bottom: 10.0, left: 5.0)),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    ScaleAnimation(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        title: TitleText('DJ Nano'),
                      ),
                    ),
                    ScaleAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150,
                              height: 200,
                              margin: EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    _albumList[currenIndex],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            0.4,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: IconButton(
                                      icon: Icon(FontAwesomeIcons.heart),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: IconButton(
                                      icon: Icon(FontAwesomeIcons.tasks),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    FadeAnimation(
                      0.6,
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: TitleText(
                          'Kids See Ghosts',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontWeight: FontWeight.w900,
                        ),
                        subtitle: SubtitleText(
                          'Kanye West',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Divider(),
                    FadeAnimation(
                      0.8,
                      Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: SubtitleText(
                              'Lorem ipsum dolor sit amet',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            subtitle: SubtitleText(
                              'Lorem ipsum',
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ]))))
    ];
  }
}

class MusicProfileImage extends StatefulWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const MusicProfileImage(
      {Key key, this.imagePath, this.isSelected = false, this.onTap})
      : super(key: key);
  @override
  _MusicProfileImageState createState() => _MusicProfileImageState();
}

class _MusicProfileImageState extends State<MusicProfileImage> {
  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      child: IconButton(
        iconSize: 80,
        splashRadius: 45,
        onPressed: widget.onTap,
        padding: EdgeInsets.zero,
        icon: AnimatedContainer(
          height: 80,
          width: 80,
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5.0,
              )
            ],
            border: !widget.isSelected
                ? Border()
                : Border.all(
                    width: 4.0,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: Image.asset(
              '${widget.imagePath}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class NowPlaying extends StatefulWidget {
  final String imagePath;

  const NowPlaying({Key key, this.imagePath}) : super(key: key);
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
  double currentValue = 20.0;
  AnimationController _animationController;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  )
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: 250,
                height: 250,
              ),
            ),
          ),
          ListTile(
            title: TitleText('Kids See Ghosts'),
            subtitle: SubtitleText('Kanye West'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
          Slider(
              label: '$currentValue',
              inactiveColor: Theme.of(context).primaryColor.withOpacity(0.4),
              activeColor: Theme.of(context).primaryColor,
              max: 100.0,
              min: 0.0,
              value: currentValue,
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.repeat)),
              IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
              FloatingActionButton(
                heroTag: 'music_play_now',
                backgroundColor: Theme.of(context).primaryColor,
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _animationController,
                ),
                onPressed: () {
                  if (isPlaying) {
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  }
                },
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
              IconButton(onPressed: () {}, icon: Icon(Icons.shuffle)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_down)),
                IconButton(onPressed: () {}, icon: Icon(Icons.file_upload)),
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
