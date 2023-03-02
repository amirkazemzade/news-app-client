import 'package:flutter/material.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:sizing/sizing_extension.dart';

class PrefixText extends StatelessWidget {
  const PrefixText({
    Key? key,
    required this.text,
    this.icon,
    this.usePrimaryColor = true,
  }) : super(key: key);

  final String text;
  final bool usePrimaryColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = usePrimaryColor
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurface;
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon!,
            color: color,
            size: 22.fss,
          ),
          sizedBoxW6,
        ],
        Text(
          '$text: ',
          style: theme.textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}
