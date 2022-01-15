import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'smartvillage_channel', //id
  'Notifikasi SmartVillage', //Title
  description: 'Notifikasi baru dari SmartVillage',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void showNotification({required String title, required String description}) {
  flutterLocalNotificationsPlugin.show(
    0,
    title,
    description,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.high,
        color: Colors.green,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      ),
    ),
  );
}
