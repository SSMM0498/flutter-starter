import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool?) onChanged;
  final TextStyle? labelStyle;

  const AppCheckbox({super.key, required this.label, required this.value, required this.onChanged, this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(value: value, onChanged: onChanged),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}
