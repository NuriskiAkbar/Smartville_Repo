import 'package:flutter/material.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const CustomDialog({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: secondaryColor, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: secondaryText.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: secondaryColor,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: secondaryColor, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onPressed: onClick,
                  child: Text(
                    'Yakin',
                    style: whiteText.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: secondaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Batal',
                    style: secondaryText.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
