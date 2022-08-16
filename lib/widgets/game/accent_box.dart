import 'dart:math';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import 'package:vi_word/widgets/game/accent_key.dart';

class AccentBox extends StatelessWidget {
  final String keyVal;
  final void Function(String) onTap;
  final bool visible;
  const AccentBox({
    Key? key,
    required this.onTap,
    required this.keyVal,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseSize = min(MediaQuery.of(context).size.width, kLayoutMaxWidth);
    final keyHeight = (baseSize / 10) * 1.4;
    final keyboardHeight = keyHeight * 3;
    final accentedKeys = constants.keyWithAccents[keyVal];

    if (accentedKeys == null) {
      return const SizedBox.shrink();
    }

    return Visibility(
      visible: visible,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: keyboardHeight + kDefaultPadding,
            child: Container(
              width: 284,
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: kDarkGrey,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: kBackground,
                  ),
                ],
              ),
              child: Column(
                children: accentedKeys
                    .map((keyRow) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: keyRow
                              .map(
                                (key) => accentedKeys.length == 1 && key == ''
                                    ? const SizedBox.shrink()
                                    : AccentKey(accentedKey: key, onTap: onTap),
                              )
                              .toList(),
                        ))
                    .toList(),
              ),
            ),
          ),
          Positioned(
            bottom: keyboardHeight + kDefaultPadding - 8,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(1 / 8),
              child: Container(
                width: 16,
                height: 16,
                color: kDarkGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
