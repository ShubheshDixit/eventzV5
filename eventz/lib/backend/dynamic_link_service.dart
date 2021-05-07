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
}
