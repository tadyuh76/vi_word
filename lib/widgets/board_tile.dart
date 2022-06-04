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
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: letter.backgroundColor.withOpacity(0.2),
        // color: letter.backgroundColor,
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
        // boxShadow: letter.status != LetterStatus.initial
        //     ? [
        //         BoxShadow(
        //           color: letter.backgroundColor,
        //           blurRadius: 4,
        //           spreadRadius: 2,
        //         ),
        //         BoxShadow(
        //           color: letter.backgroundColor,
        //           blurRadius: 8,
        //           spreadRadius: 2,
        //           inset: true,
        //         ),
        //       ]
        //     : null,
      ),
      child: Text(
        letter.val.toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.55, color: Colors.white,
          // color: letter.status == LetterStatus.notInWord ? kGrey : Colors.white,
          // color: letter.status != LetterStatus.initial
          //     ? letter.backgroundColor
          //     : Colors.white,
          // shadows: letter.status != LetterStatus.initial
          //     ? [
          //         Shadow(
          //           color: letter.backgroundColor,
          //           blurRadius: 2,
          //         )
          //       ]
          //     : null,
        ),
      ),
    );
  }
}
