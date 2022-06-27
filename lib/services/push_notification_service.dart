import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:my_green_app/constants/routes_path.dart' as routes;

class PushNotificationService {
  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAW_9lKRA:APA91bFJkK4zXIzF2UM7ahoz5NCJfZ74-wCPw2NJ6DcTAQ0SuwFMkV0oh8bKyzOK5rG7P2vicrUv3L5sLbF3Ui6JIDRji3cWJdn5-W30-xHbvH3C32P7pphSITYaFjUvFE1qPNOG_TY5',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'route': routes.appointmentRoute
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }
}
