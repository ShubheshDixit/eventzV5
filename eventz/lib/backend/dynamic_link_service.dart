import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  Future handleDynamicLinks(context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      await _handleDeepLink(dynamicLinkData, context);
    }, onError: (OnLinkErrorException e) async {
      print('Dynamic Link Failed: ${e.message}');
    });
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    await _handleDeepLink(data, context);
  }

  Future<void> _handleDeepLink(
      PendingDynamicLinkData data, BuildContext context) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      final url = Uri.parse(deepLink.toString().replaceAll('#', ''));
      print('_handleDeepLink | deepLink $url');
      var isRoom = url.pathSegments.contains('room');
      print(url.queryParametersAll);
      if (isRoom) {
        var roomId = url.queryParameters['roomId'];
        var subject = url.queryParameters['subject'];
        if (roomId != null) {
          print(roomId);
        }
      }
    }
  }

  Future<Uri> createEventsDynamicLink(
      String title, String description, String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://v5online.page.link',
      link: Uri.parse('https://v5online.com/event/$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.v5.eventz',
        minimumVersion: 125,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.v5.eventz',
        minimumVersion: '1.0.0',
        appStoreId: '1563606386',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Check out this amazing event from V5.\n$title',
        description: description,
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl;
  }

  Future<Uri> createShortEventLink(String id) async {
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      Uri.parse(
          'https://v5online.page.link/?link=https://v5online.com/event/$id&apn=com.v5.eventz&ibn=com.v5.eventz'),
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );

    final Uri shortUrl = shortenedLink.shortUrl;
    return shortUrl;
  }

  Future<Uri> createShortLink(
      {String link, String title, String description}) async {
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      Uri.parse(
          'https://v5online.page.link/?link=$link&apn=com.v5.eventz&ibn=com.v5.eventz&title:$title&description:$description'),
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );

    final Uri shortUrl = shortenedLink.shortUrl;
    return shortUrl;
  }
}
