import 'package:flutter/material.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/widgets/keyboard/keyboard_key.dart';

class Keyboard extends StatefulWidget {
  final void Function(String) onKeyTap, onLimitedKeyTap;
  final VoidCallback onEnterTap, onDeleteTap;
  final List<Letter> specialKeys;

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
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
      child: Column(
        children: keyRows
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((key) {
                  if (key == enterKey) {
                    return KeyboardKey.enter(onTap: widget.onEnterTap);
                  }
                  if (key == delKey) {
                    return KeyboardKey.delete(onTap: widget.onDeleteTap);
                  }
                  if (limitedKeys.contains(key)) {
                    return KeyboardKey.limitedKey(
                      keyVal: key,
                      onTap: () => widget.onLimitedKeyTap(key),
                    );
                  }

                  Letter currentKey = widget.specialKeys.firstWhere(
                    (e) => e.val == key,
                    orElse: () => Letter.empty(),
                  );

                  return KeyboardKey(
                    keyVal: key,
                    onTap: () => widget.onKeyTap(key),
                    backgroundColor: currentKey.val == ''
                        ? kGrey
                        : currentKey.backgroundColor,
                  );
                }).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
