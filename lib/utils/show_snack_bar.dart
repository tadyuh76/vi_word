import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required Color backgroundColor,
  required String text,
  Duration? duration,
  VoidCallback? onTap,
}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: backgroundColor,
    elevation: 4,
    duration: duration ?? const Duration(seconds: 4),
  );

  ScaffoldMessenger.of(context).clearSnackBars(); // prevent spam
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
