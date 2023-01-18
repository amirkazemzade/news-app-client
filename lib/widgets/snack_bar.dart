import 'package:flutter/material.dart';

SnackBar snackBar(BuildContext context, String message,
    {bool isError = false}) {
  var colorScheme = Theme.of(context).colorScheme;
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: TextStyle(
        color: isError
            ? colorScheme.onErrorContainer
            : colorScheme.onInverseSurface,
      ),
    ),
    duration: const Duration(seconds: 3),
    backgroundColor:
        isError ? colorScheme.errorContainer : colorScheme.inverseSurface,
  );
}
