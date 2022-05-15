import 'dart:math';

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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final baseSize = min(constraints.maxHeight, constraints.maxWidth);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: board
                .map(
                  (word) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: word.letters
                        .map((letter) => BoardTile(
                              letter: letter,
                              size: baseSize / 7,
                            ))
                        .toList(),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
