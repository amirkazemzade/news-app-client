import 'package:flutter/material.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    required this.child,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      onPressed: onPressed,
      child: isLoading
          ? StyledLoadingIndicator(width: 20, color: colorScheme.onPrimary)
          : child,
    );
  }
}
