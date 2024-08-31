import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final Widget label;
  final bool value;
  final void Function(bool?) onChanged;

  const AppCheckbox({super.key, required this.label, required this.value, required this.onChanged});

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
          label,
        ],
      ),
    );
  }
}
