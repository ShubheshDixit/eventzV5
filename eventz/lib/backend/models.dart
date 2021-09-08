import 'package:cloud_firestore/cloud_firestore.dart';

Map weekDays = {
  1: 'Sunday',
  2: 'Monday',
  3: 'Tuesday',
  4: 'Wednesday',
  5: 'Thursday',
  6: 'Friday',
  7: 'Saturday'
};

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
      description,
      showUrl,
      formUrl,
      v5Url,
      bannerUrl,
      eventType,
      imageUrl,
      videoUrl,
      spotifyUrl,
      venue;
  final double lat, lng;
  final int eventDay;
  final Timestamp eventDate, timestamp;
  final Map timing;
  final Map<String, dynamic> ageLimit;
  final bool isPaused;

  Event(
      {this.title,
      this.id,
      this.description,
      this.showUrl,
      this.formUrl,
      this.bannerUrl,
      this.ageLimit,
      this.timing,
      this.eventType,
      this.eventDay,
      this.eventDate,
      this.imageUrl,
      this.videoUrl,
      this.spotifyUrl,
      this.isPaused,
      this.venue,
      this.lat,
      this.lng,
      this.timestamp,
      this.v5Url});
  factory Event.fromDoc(DocumentSnapshot doc) {
    return Event(
      id: doc.get('id'),
      title: doc.get('title'),
      description: doc.get('description'),
      showUrl: doc.get('showUrl'),
      formUrl: doc.get('formUrl'),
      v5Url: doc.get('v5Url'),
      bannerUrl: doc.get('bannerUrl'),
      videoUrl: doc.get('videoUrl'),
      spotifyUrl: doc.get('spotifyUrl'),
      ageLimit: doc.get('ageLimit'),
      eventType: doc.get('eventType'),
      eventDay: doc.get('eventDay'),
      eventDate: doc.get('eventDate'),
      imageUrl: doc.get('imageUrl'),
      isPaused: doc.get('isPaused'),
      lat: doc.get('lat'),
      lng: doc.get('lng'),
      venue: doc.get('venue'),
      timestamp: doc.get('timestamp'),
      timing: doc.get('timing'),
    );
  }
  // factory Event.fromMap(Map doc) {
  //   return Event(
  //       id: doc['event_id'],
  //       creatorName: doc['seller_id'],
  //       title: doc['event'],
  //       venue: doc['venue_id'],
  //       lat: 8.0,
  //       long: 173,
  //       subtitle: 'ages: ' + doc['ages'],
  //       date: Timestamp.fromDate(DateTime.parse(doc['event_start'])),
  //       description: doc['description'],
  //       posterURL: doc['image_url'] ??
  //           'https://sc-schemes.s3.amazonaws.com/30176/header_image.png',
  //       imageURLs: [doc['image']],
  //       category: doc['event_category_id'],
  //       ticketPrice: doc['price'] ?? 10.4,
  //       pricingUrl: doc['price_levels'],
  //       listingUrl: doc['listing_url']);
  // }

  // toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'showUrl': showUrl,
  //     'formUrl': formUrl,
  //     'date': date,
  //     'posterURL': posterURL,
  //     'imageURLs': imageURLs,
  //     'tags': tags,
  //     'category': category,
  //     'ticketPrice': ticketPrice,
  //   };
  // }
}

class Product {
  final int price, stockUnit;
  final String id, title, description, imageUrl;
  final bool isOut;
  final List sizes;

  Product(
      {this.price,
      this.stockUnit,
      this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.isOut,
      this.sizes});

  factory Product.fromDoc(DocumentSnapshot doc) {
    return Product(
      id: doc.get('id'),
      title: doc.get('title'),
      imageUrl: doc.get('imageUrl'),
      description: doc.get('description'),
      price: doc.get('price'),
      stockUnit: doc.get('stockUnit'),
      sizes: doc.get('sizes'),
    );
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
