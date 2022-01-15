import 'package:flutter/material.dart';
import 'package:smartville/common/colors.dart';

class CustomSelectOption extends StatefulWidget {
  final List<String> items;
  final Function(String? string) onChanged;
  const CustomSelectOption({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSelectOption> createState() => _CustomSelectOptionState();
}

class _CustomSelectOptionState extends State<CustomSelectOption> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = widget.items[0];

    return DropdownButtonFormField<String>(
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
      ),
      value: selectedItem,
      onChanged: widget.onChanged,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
