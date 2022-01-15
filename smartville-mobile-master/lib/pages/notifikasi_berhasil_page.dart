import 'package:flutter/material.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/pages/dashboard_page.dart';
import 'package:smartville/pages/login_page.dart';

class NotifikasiBerhasilPage extends StatefulWidget {
  const NotifikasiBerhasilPage({
    Key? key,
    this.notificationMessage,
  }) : super(key: key);
  static const routeName = 'notifikasi_berhasil_page';
  final NotificationMessage? notificationMessage;
  @override
  _NotifikasiBerhasilPageState createState() => _NotifikasiBerhasilPageState();
}

class _NotifikasiBerhasilPageState extends State<NotifikasiBerhasilPage> {
  _navigateTo(String page) {
    if (page.contains("dashboard")) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        DashboardPage.routeName,
        (Route<dynamic> route) => false,
      );
    } else if (page.contains("login")) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginPage.routeName,
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFB6DFD9),
            ),
            FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF79AFA7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(58),
                    bottomRight: Radius.circular(58),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: const Color(0xFFE3F4F2),
                    borderRadius: BorderRadius.circular(26.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(widget.notificationMessage?.imageAssets ?? ""),
                    const SizedBox(height: 8),
                    Text(
                      widget.notificationMessage?.title ?? "",
                      style: greyText.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.notificationMessage?.message ?? "",
                        textAlign: TextAlign.center, style: greyText),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        onPressed: () {
                          _navigateTo(
                              widget.notificationMessage?.navigateTo ?? "");
                        },
                        child: Text(
                          widget.notificationMessage?.textButton ?? "",
                          style: blackText.copyWith(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
