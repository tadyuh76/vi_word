import 'package:flutter/material.dart';
import 'package:vi_word/utils/constants.dart' as constants;

class AccentBox extends StatelessWidget {
  const AccentBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardHeight = size.width / 10 * 4;

    return Visibility(
      child: Positioned(
        bottom: keyboardHeight + constants.defaultPadding * 2,
        right: constants.defaultPadding,
        left: constants.defaultPadding,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // small triangle at the bottom
            Positioned(
              bottom: 0,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.grey[300],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  [1, 2, 3, 4],
                  [1, 2, 3, 4]
                ]
                    .map((e) => Row(
                          children: e.map((e) => Text('$e')).toList(),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
