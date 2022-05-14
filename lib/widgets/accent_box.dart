import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;
    final keyboardHeight = size.width / 10 * 4;
    final accentedKeys = constants.keyWithAccents[keyVal];

    return accentedKeys != null
        ? Visibility(
            visible: visible,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: keyboardHeight + constants.defaultPadding * 2 + 5,
                  child: Container(
                    width: size.width * 0.6,
                    padding: const EdgeInsets.all(constants.defaultPadding / 3),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: accentedKeys
                          .map((e) => Row(
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
                Positioned(
                  bottom: keyboardHeight + constants.defaultPadding * 2,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(45 / 360),
                    child: Container(
                      width: 10,
                      height: 10,
                      color: primary,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
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
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black26,
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
    );
  }
}
