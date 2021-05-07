import 'package:eventz/global_values.dart';
import 'package:eventz/pages/events_home_page.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TitleText('Search'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                InfoTile(
                  title: TitleText('Find Events'),
                  subtitle: SubtitleText('Search for events that you like.'),
                  image: Image.asset(
                    GlobalValues.searchImage,
                    width: 500,
                    height: 500,
                  ),
                  overflowWidget: Hero(
                    tag: 'search_text_bar',
                    child: Material(
                      color: Colors.transparent,
                      child: SearchBar(
                        isReadOnly: false,
                        controller: _controller,
                        onSubmitted: (text) {
                          print(text);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
