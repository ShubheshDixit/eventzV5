import 'package:eventz/backend/mock_data.dart';
import 'package:eventz/pages/events_home_page.dart';
import 'package:eventz/pages/global_widgets.dart';
import 'package:flutter/material.dart';

class AllEventsPage extends StatefulWidget {
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText('All Events'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid.count(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 4
                      : 2,
              // mainAxisSpacing: 10,
              // crossAxisSpacing: 10,
              childAspectRatio: 240 / 420,
              children: List.generate(eventsList.length, (index) {
                return EventTile(
                  isVerticle: true,
                  isFull: false,
                  imageURL: eventsList.reversed.toList()[index].posterURL,
                  title: eventsList.reversed.toList()[index].title,
                  subtitle: eventsList.reversed.toList()[index].subtitle,
                  creator: eventsList.reversed.toList()[index].creatorName,
                  distance: '1.8',
                  date: eventsList.reversed.toList()[index].date.toDate(),
                  description: eventsList.reversed.toList()[index].description,
                  ticketPrice: eventsList.reversed
                      .toList()[index]
                      .ticketPrice
                      .toString(),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
