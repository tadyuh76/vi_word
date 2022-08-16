import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';

class KeyboardKey extends StatelessWidget {
  final IconData? icon;
  final String keyVal;
  final VoidCallback onTap;
  final Color backgroundColor;

  const KeyboardKey({
    Key? key,
    this.icon,
    this.backgroundColor = kGrey,
    required this.keyVal,
    required this.onTap,
  }) : super(key: key);

  factory KeyboardKey.enter({onTap}) {
    return KeyboardKey(
      keyVal: enterKey,
      onTap: onTap,
      icon: Icons.keyboard_double_arrow_right,
      backgroundColor: kMediumGrey,
    );
  }

  factory KeyboardKey.delete({onTap}) {
    return KeyboardKey(
      keyVal: delKey,
      onTap: onTap,
      icon: Icons.backspace,
      backgroundColor: kMediumGrey,
    );
  }

  factory KeyboardKey.limitedKey({keyVal, onTap}) {
    return KeyboardKey(keyVal: keyVal, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    final baseWidth = min(
      MediaQuery.of(context).size.width,
      kLayoutMaxWidth,
    );
    final keyWidth = (baseWidth - kDefaultPadding / 2) / keyRows[0].length - 4;
    final bool isNotVietnamese = {'w', 'f', 'j', 'z'}.contains(keyVal);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width:
                [enterKey, delKey].contains(keyVal) ? 1.5 * keyWidth : keyWidth,
            height: 1.4 * keyWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isNotVietnamese
                    ? [kMediumGrey, darken(kMediumGrey, 0.2)]
                    : [backgroundColor, darken(backgroundColor, 0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: icon != null
                ? Icon(icon, size: 26, color: Colors.white)
                : Text(
                    keyVal,
                    style: TextStyle(fontSize: keyWidth * 0.5),
                  ),
          ),
        ),
      ),
    );
  }
}
