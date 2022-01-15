import 'dart:io';

class NotificationMessage {
  String? imageAssets;
  String? title;
  String? message;
  String? textButton;
  String? navigateTo;

  NotificationMessage({
    this.imageAssets,
    this.title,
    this.message,
    this.textButton,
    this.navigateTo,
  });
}
