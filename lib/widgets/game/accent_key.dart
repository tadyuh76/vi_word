import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';

class AccentKey extends StatelessWidget {
  final String accentedKey;
  final void Function(String) onTap;
  const AccentKey({
    Key? key,
    required this.accentedKey,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEmptyAccent = accentedKey == '';

    return IgnorePointer(
      ignoring: isEmptyAccent,
      child: Opacity(
        opacity: isEmptyAccent ? 0 : 1,
        child: InkWell(
          onTap: () => onTap(accentedKey),
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: kMediumGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                accentedKey,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
