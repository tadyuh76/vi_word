import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';

void showSnackBar({
  required BuildContext context,
  required Color backgroundColor,
  required String text,
  VoidCallback? onTap,
}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: red,
    elevation: 4,
  );

  ScaffoldMessenger.of(context).clearSnackBars(); // prevent spam
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
