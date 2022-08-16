import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/enums.dart';

class BoardTile extends StatelessWidget {
  final Letter letter;
  final double size;
  const BoardTile({Key? key, required this.letter, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            letter.backgroundColor,
            darken(letter.backgroundColor, 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: letter.status == LetterStatus.initial
            ? Border.all(
                color: letter.borderColor,
                width: 1,
              )
            : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        letter.val.toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.55,
          color: Colors.white,
        ),
      ),
    );
  }
}
