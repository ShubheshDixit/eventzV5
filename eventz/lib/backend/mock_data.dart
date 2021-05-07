import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventz/backend/models.dart';

List<Event> eventsList = [
  Event(
    posterURL: 'images/posters/nano.jpeg',
    title: 'DJ Nano',
    subtitle: 'Village Roadhouse',
    creatorName: 'V5',
    date: Timestamp.fromDate(DateTime(2021, 2, 27)),
    description:
        'Tonight is going to be an awesome night. Get ready to rock your world.',
    ticketPrice: double.parse('18.4'),
  ),
  Event(
    posterURL: 'images/posters/baila.jpeg',
    title: 'DJ JStar',
    subtitle: 'Baila Fridays',
    creatorName: 'V5',
    date: Timestamp.fromDate(DateTime(2021, 2, 5)),
    description:
        'Tonight is going to be an awesome night. Get ready to rock your world.',
    ticketPrice: double.parse('18.4'),
  ),
  Event(
    posterURL: 'images/posters/luxur.jpeg',
    title: 'DJ OZONE',
    subtitle: 'Luxur Saturdays',
    creatorName: 'V5',
    date: Timestamp.fromDate(DateTime(2021, 3, 12)),
    description:
        'Tonight is going to be an awesome night. Get ready to rock your world.',
    ticketPrice: double.parse('18.4'),
  ),
  Event(
    posterURL: 'images/posters/brunch.jpeg',
    title: 'Brunch : This saturday',
    subtitle: 'V5 DJs',
    creatorName: 'V5',
    date: Timestamp.fromDate(DateTime(2021, 7, 13)),
    description:
        'Tonight is going to be an awesome night. Get ready to rock your world.',
    ticketPrice: double.parse('16.1'),
  ),
];

Event myEvent = Event(
  title: 'Music Event',
  date: Timestamp.fromDate(DateTime(2021, 4, 4)),
  subtitle: 'Club Freedom',
  creatorName: 'Shubh',
  description: 'Just a test event.',
  ticketPrice: 22.0,
  posterURL: 'images/posters/my_event.jpeg',
);
