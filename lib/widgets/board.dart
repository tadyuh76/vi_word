import 'package:flutter/material.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/widgets/board_tile.dart';

class Board extends StatelessWidget {
  final List<Word> board;
  const Board({
    Key? key,
    required this.board,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: board
          .map(
            (word) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: word.letters
                  .map((letter) => BoardTile(letter: letter))
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
