import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:vi_word/utils/color_changer.dart';

void showSnackBar({
  required BuildContext context,
  required Color backgroundColor,
  required String text,
  Duration? duration,
  VoidCallback? onTap,
}) {
  final snackBar = Material(
    color: Colors.transparent,
    child: SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [backgroundColor, darken(backgroundColor, .4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor,
                  blurRadius: 10,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(12)),
              child: SvgPicture.asset(
                'assets/bubbles.svg',
                height: 36,
                width: 36,
                color: darken(backgroundColor, 0.3),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: -16,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/fail.svg',
                  width: 30,
                  height: 30,
                  color: darken(backgroundColor, 0.3),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );

  // prevent spam
  _closeSnackBars(context);
  showTopSnackBar(context, snackBar);
}

void _closeSnackBars(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}
