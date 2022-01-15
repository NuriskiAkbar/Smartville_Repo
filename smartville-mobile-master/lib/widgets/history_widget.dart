import 'package:flutter/material.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/utils/date_convert.dart';

class HistoryWidget extends StatelessWidget {
  String title;
  DateTime date;
  String status;
  HistoryWidget({
    Key? key,
    required this.title,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFC5E3DF),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 5),
                  Text(
                    dateForHistory(date.toLocal()),
                    style: blackText.copyWith(color: redColor),
                  ),
                ],
              ),
            ),
            Text(
              status,
              style: primaryText.copyWith(
                fontWeight: FontWeight.w600,
                color: status == "terkirim"
                    ? primaryColor
                    : status == "diterima"
                        ? Colors.blue
                        : redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
