import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/utils/colors.dart';

class BoardTile extends StatelessWidget {
  final Letter letter;
  final double size;
  const BoardTile({Key? key, required this.letter, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(4),
        padding: EdgeInsets.only(top: size * 0.05),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kBackground,
          border: Border.all(color: letter.borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: letter.backgroundColor,
              spreadRadius: 2,
              blurRadius: 4,
            ),
            BoxShadow(
              color: letter.backgroundColor,
              spreadRadius: 4,
              blurRadius: 4,
              inset: true,
            ),
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          letter.val.toUpperCase(),
          style: TextStyle(
            fontSize: size * 0.6,
            fontWeight: FontWeight.bold,
            color:
                letter.status == LetterStatus.notInWord ? kGrey : Colors.white,
            shadows: [
              Shadow(
                color: letter.backgroundColor,
                blurRadius: 20,
              )
            ],
          ),
        ),
      );
    });
  }
}
