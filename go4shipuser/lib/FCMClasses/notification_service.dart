import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requestNotificationPermission() async{
    NotificationSettings settings= await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print('user granted provisional permission');
    }else{
     // AppleNotificationSetting.open
      print('user denied  permission');
    }
  }

  Future<String> getToken() async{
    String? token= await messaging.getToken();
    return  token!;
  }
}