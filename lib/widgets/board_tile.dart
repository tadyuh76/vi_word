import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/models/letter.dart';
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
        color: letter.backgroundColor.withOpacity(0.2),
        border: Border.all(color: letter.borderColor, width: 2),
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
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        letter.val.toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.6,
          // color: letter.status == LetterStatus.notInWord ? kGrey : Colors.white,
          color: letter.status != LetterStatus.initial
              ? letter.backgroundColor
              : Colors.white,
          shadows: letter.status != LetterStatus.initial
              ? [
                  Shadow(
                    color: letter.backgroundColor,
                    blurRadius: 2,
                  )
                ]
              : null,
        ),
      ),
    );
  }
}
