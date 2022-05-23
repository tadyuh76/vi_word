import 'dart:math';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;

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
    final keyboardHeight = baseSize / 10 * 4;
    final accentedKeys = constants.keyWithAccents[keyVal];

    if (accentedKeys == null) {
      return Container();
    }

    return Visibility(
      visible: visible,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: keyboardHeight + kDefaultPadding + 5,
            child: Container(
              width: baseSize * 0.6,
              padding: const EdgeInsets.all(kDefaultPadding / 3),
              decoration: BoxDecoration(
                  border: Border.all(color: kDarkGrey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [kMediumGrey, kDarkGrey],
                    begin: Alignment(-0.6, -.6),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: accentedKeys
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: e
                              .map(
                                (e) => accentedKeys.length == 1 && e == ''
                                    ? Container()
                                    : _AccentedKey(
                                        accentedKey: e,
                                        onTap: onTap,
                                      ),
                              )
                              .toList(),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccentedKey extends StatelessWidget {
  final String accentedKey;
  final void Function(String) onTap;
  const _AccentedKey({
    Key? key,
    required this.accentedKey,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEmptyAccent = accentedKey == '';

    return Flexible(
      flex: 1,
      child: IgnorePointer(
        ignoring: isEmptyAccent,
        child: Opacity(
          opacity: isEmptyAccent ? 0 : 1,
          child: InkWell(
            onTap: () => onTap(accentedKey),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 50),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    accentedKey,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
