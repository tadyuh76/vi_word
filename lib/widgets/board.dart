import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/widgets/board_tile.dart';

class Board extends StatelessWidget {
  final List<Word> board;
  final List<List<FlipCardController>> flipCardControllers;
  const Board({
    Key? key,
    required this.board,
    required this.flipCardControllers,
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
                .asMap()
                .map(
                  (i, word) => MapEntry(
                    i,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: word.letters
                          .asMap()
                          .map((j, letter) => MapEntry(
                                j,
                                FlipCard(
                                  controller: flipCardControllers[i][j],
                                  flipOnTouch: false,
                                  // direction: FlipDirection.HORIZONTAL,
                                  front: BoardTile(
                                    letter: Letter(val: letter.val),
                                    size: (baseSize / 6) - 8,
                                  ),
                                  back: BoardTile(
                                    letter: letter,
                                    size: (baseSize / 6) - 8,
                                  ),
                                ),
                              ))
                          .values
                          .toList(),
                    ),
                  ),
                )
                .values
                .toList(),
          );
        },
      ),
    );
  }
}
