import 'package:flutter/material.dart';
import 'package:vi_word/models/letter.dart';

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
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: letter.borderColor, width: 2),
          color: letter.backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          letter.val.toUpperCase(),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }
}
