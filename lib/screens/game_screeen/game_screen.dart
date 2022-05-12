import 'package:flutter/material.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/modules/game.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/widgets/board.dart';
import 'package:vi_word/widgets/keyboard.dart';

enum GameStatus { playing, won, lost, submiting }

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Word> _board = Game.initBoard;
  int _currentIndex = 0;
  GameStatus _gameStatus = GameStatus.playing;

  Word? get _currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;
  String get _solution => 'conheo';

  void onKeyTap(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

  void onDeleteTap() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  void onEnterTap() {
    if (_gameStatus == GameStatus.playing &&
        _currentWord != null &&
        !_currentWord!.letters.contains(Letter.empty())) {
      _gameStatus = GameStatus.submiting;
      print('');

      for (int i = 0; i < _currentWord!.letters.length; i++) {
        final currentWordLetter = _currentWord!.letters[i];
        final currentSolutionLetter = _solution[i];

        if (currentWordLetter.val == currentSolutionLetter) {
          currentWordLetter.copyWith(status: LetterStatus.correct);
        } else if (_solution.contains(currentWordLetter.val)) {
          currentWordLetter.copyWith(status: LetterStatus.wrongPosition);
        } else {
          currentWordLetter.copyWith(status: LetterStatus.notInWord);
        }
      }
      setState(() {
        _currentIndex = _currentIndex + 1;
        _gameStatus = GameStatus.playing;
        _board = [
          Word(letters: [Letter.empty()])
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(appName),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline4!.copyWith(
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
      ),
      body: Column(
        children: [
          Board(board: _board),
          const SizedBox(height: 24),
          Keyboard(
            onKeyTap: onKeyTap,
            onEnterTap: onEnterTap,
            onDeleteTap: onDeleteTap,
          ),
        ],
      ),
    );
  }
}
