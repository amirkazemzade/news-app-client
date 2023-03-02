import 'package:flutter/material.dart';

class CheckBoxTile extends StatelessWidget {
  const CheckBoxTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.actionOnCheckBoxOnly = true,
  }) : super(key: key);

  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool actionOnCheckBoxOnly;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: actionOnCheckBoxOnly ? null : () => onChanged(!value),
      leading: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: colorScheme.primary,
        checkColor: colorScheme.onPrimary,
      ),
      title: Text(title),
    );
  }
}
