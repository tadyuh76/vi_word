import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';

class Keyboard extends StatefulWidget {
  final void Function(String) onKeyTap, onLimitedKeyTap;
  final VoidCallback onEnterTap, onDeleteTap;
  final Set<Letter> specialKeys;

  const Keyboard({
    Key? key,
    required this.onKeyTap,
    required this.onLimitedKeyTap,
    required this.onEnterTap,
    required this.onDeleteTap,
    required this.specialKeys,
  }) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    final limitedKeys = {'w', 'f', 'j', 'z'};

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: Column(
        children: keyRows
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((key) {
                  if (key == enterKey) {
                    return _KeyboardButton.enter(onTap: widget.onEnterTap);
                  }
                  if (key == delKey) {
                    return _KeyboardButton.delete(onTap: widget.onDeleteTap);
                  }
                  if (limitedKeys.contains(key)) {
                    return _KeyboardButton.limitedKey(
                      keyVal: key,
                      onTap: () => widget.onLimitedKeyTap(key),
                    );
                  } else {
                    Letter currentKey = widget.specialKeys.firstWhere(
                      (e) => e.val == key,
                      orElse: () => Letter.empty(),
                    );

                    return _KeyboardButton(
                      keyVal: key,
                      onTap: () => widget.onKeyTap(key),
                      backgroundColor: currentKey.val == ''
                          ? kGrey
                          : currentKey.backgroundColor,
                    );
                  }
                }).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final IconData? icon;
  final String keyVal;
  final VoidCallback onTap;
  final Color backgroundColor;

  const _KeyboardButton({
    Key? key,
    this.icon,
    this.backgroundColor = kGrey,
    required this.keyVal,
    required this.onTap,
  }) : super(key: key);

  factory _KeyboardButton.enter({onTap}) {
    return _KeyboardButton(
      keyVal: enterKey,
      onTap: onTap,
      icon: Icons.keyboard_double_arrow_right,
    );
  }

  factory _KeyboardButton.delete({onTap}) {
    return _KeyboardButton(
      keyVal: delKey,
      onTap: onTap,
      icon: Icons.keyboard_return,
    );
  }

  factory _KeyboardButton.limitedKey({keyVal, onTap}) {
    return _KeyboardButton(keyVal: keyVal, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    final baseWidth = min(
      MediaQuery.of(context).size.width,
      kLayoutMaxWidth,
    );
    final keyWidth = (baseWidth - kDefaultPadding) / keyRows[0].length - 4;
    final bool isNotVietnamese = {'w', 'f', 'j', 'z'}.contains(keyVal);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      child: Material(
        color: isNotVietnamese ? kDarkGrey : backgroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width:
                [enterKey, delKey].contains(keyVal) ? 1.5 * keyWidth : keyWidth,
            height: 1.3 * keyWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: icon != null
                ? Icon(icon, size: 32)
                : Text(
                    keyVal,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
