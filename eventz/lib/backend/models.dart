import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String displayName, email, phoneNumber, uid, photoURL;
  final bool isVIP;

  MyUser({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.uid,
    this.isVIP,
    this.photoURL,
  });

  factory MyUser.fromDoc(DocumentSnapshot doc) {
    return MyUser(
        photoURL: doc.get('photoURL'),
        displayName: doc.get('displayName'),
        email: doc.get('email'),
        phoneNumber: doc.get('phoneNumber'),
        uid: doc.get('uid'),
        isVIP: doc.get('isVIP'));
  }

  toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'isVIP': isVIP,
      'photoURL': photoURL,
    };
  }
}

class Event {
  final String title,
      subtitle,
      description,
      posterURL,
      category,
      creatorName,
      venue;
  final double ticketPrice, lat, long;
  final List<String> imageURLs, tags;
  final Timestamp date;

  Event(
      {this.title,
      this.venue,
      this.lat,
      this.long,
      this.creatorName,
      this.description,
      this.date,
      this.subtitle,
      this.posterURL,
      this.ticketPrice,
      this.imageURLs,
      this.tags,
      this.category});

  factory Event.fromDoc(DocumentSnapshot doc) {
    return Event(
        creatorName: doc.get('creatorName'),
        title: doc.get('title'),
        venue: doc.get('venue'),
        lat: doc.get('lat'),
        long: doc.get('long'),
        subtitle: doc.get('subtitle'),
        date: doc.get('date'),
        description: doc.get('description'),
        posterURL: doc.get('posterURL'),
        imageURLs: doc.get('imageURLs'),
        tags: doc.get('tags'),
        category: doc.get('category'),
        ticketPrice: doc.get('ticketPrice'));
  }

  toJson() {
    return {
      'venue': venue,
      'lat': lat,
      'long': long,
      'creatorName': creatorName,
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'description': description,
      'posterURL': posterURL,
      'imageURLs': imageURLs,
      'tags': tags,
      'category': category,
      'ticketPrice': ticketPrice,
    };
  }
}
