import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartville/common/colors.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String textHint;
  final bool typeNumber;
  bool obsecureText;
  final IconData? prefixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool isStrictLength;
  final bool enable;
  IconData? suffixIcon;
  final bool typeMultiline;
  bool passwordVisible;

  CustomFormField({
    Key? key,
    this.prefixIcon,
    required this.textEditingController,
    required this.textHint,
    this.typeNumber = false,
    this.obsecureText = false,
    this.readOnly = false,
    this.onTap,
    this.maxLength,
    this.maxLengthEnforcement,
    this.isStrictLength = false,
    this.enable = true,
    this.suffixIcon,
    this.passwordVisible = false,
    this.typeMultiline = false,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obsecureText,
      keyboardType: widget.typeNumber
          ? TextInputType.number
          : widget.typeMultiline
              ? TextInputType.multiline
              : TextInputType.text,
      inputFormatters: widget.typeNumber == true
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap isi bagian ini';
        }
        if (widget.isStrictLength) {
          if (value.length < widget.maxLength!) {
            return 'Panjang karakter harus ${widget.maxLength} digit';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        fillColor: const Color(0xFFDEEDEB),
        filled: true,
        hintText: widget.textHint,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(
                  widget.obsecureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    widget.obsecureText = !widget.obsecureText;
                  });
                },
              )
            : null,
      ),
      onTap: widget.onTap,
      enabled: widget.enable,
      readOnly: widget.readOnly,
      controller: widget.textEditingController,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      minLines: widget.typeMultiline ? 3 : 1,
      maxLines: widget.typeMultiline ? 4 : 1,
    );
  }
}
