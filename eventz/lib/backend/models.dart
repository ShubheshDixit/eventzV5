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
      id,
      listingUrl,
      subtitle,
      description,
      posterURL,
      category,
      creatorName,
      pricingUrl,
      venue;
  final double ticketPrice, lat, long;
  final List<String> imageURLs, tags;
  final Timestamp date;

  Event(
      {this.title,
      this.id,
      this.listingUrl,
      this.pricingUrl,
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
        id: doc.get('event_id'),
        creatorName: doc.get('seller_id'),
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
        pricingUrl: doc.get('pricingURL'),
        ticketPrice: doc.get('ticketPrice'));
  }
  factory Event.fromMap(Map doc) {
    return Event(
        id: doc['event_id'],
        creatorName: doc['seller_id'],
        title: doc['event'],
        venue: doc['venue_id'],
        lat: 8.0,
        long: 173,
        subtitle: 'ages: ' + doc['ages'],
        date: Timestamp.fromDate(DateTime.parse(doc['event_start'])),
        description: doc['description'],
        posterURL: doc['image_url'] ??
            'https://sc-schemes.s3.amazonaws.com/30176/header_image.png',
        imageURLs: [doc['image']],
        category: doc['event_category_id'],
        ticketPrice: doc['price'] ?? 10.4,
        pricingUrl: doc['price_levels'],
        listingUrl: doc['listing_url']);
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

class StoreItem {
  final String title, imageURL, description, id;
  final double price;

  StoreItem({this.title, this.imageURL, this.description, this.price, this.id});
  factory StoreItem.fromDoc(DocumentSnapshot doc) {
    return StoreItem(
      id: doc.get('id'),
      title: doc.get('title'),
      imageURL: doc.get('imageURL'),
      description: doc.get('description'),
      price: doc.get('price'),
    );
  }
  factory StoreItem.fromMap(Map doc) {
    return StoreItem(
      id: doc['id'],
      title: doc['title'],
      imageURL: doc['imageURL'],
      description: doc['description'],
      price: doc['price'],
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'imageURL': imageURL,
      'price': price,
    };
  }
}

class Chat {
  final String senderId, senderName, msg;
  final List<String> mediaUrls;
  final Timestamp timestamp;

  Chat(
      {this.timestamp,
      this.senderId,
      this.senderName,
      this.msg,
      this.mediaUrls});

  factory Chat.fromDoc(DocumentSnapshot doc) {
    return Chat(
        msg: doc.get('msg'),
        senderId: doc.get('senderId'),
        senderName: doc.get('senderName'),
        mediaUrls: doc.get('mediaUrls'),
        timestamp: doc.get('timestamp'));
  }
}
