import 'package:flutter/material.dart';
import 'package:vi_word/models/models.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import 'package:vi_word/utils/show_snack_bar.dart';
import 'package:vi_word/widgets/accent_box.dart';
import 'package:vi_word/widgets/widgets.dart';

enum GameStatus { playing, won, lost, submiting }

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Word> _board = constants.initBoard;
  int _currentIndex = 0;
  GameStatus _gameStatus = GameStatus.playing;

  Word? get _currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;
  String get _solution => 'conheo';

  final Set<Letter> specialKeys = {};

  void onKeyTap(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

  void onLimitedKeyTap(String key) {
    showSnackBar(
      context: context,
      backgroundColor: red,
      text: 'Chữ $key không có trong Tiếng Việt !',
    );
  }

  void onAccentTap(String key) {
    print('$key tapped');
  }

  void onDeleteTap() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  void onEnterTap() {
    showSnackBar(
      context: context,
      backgroundColor: red,
      text: 'enter',
    );
    if (_gameStatus == GameStatus.playing &&
        _currentWord != null &&
        _currentWord!.letters.every((e) => e.val != '')) {
      // prevent spam enter
      _gameStatus = GameStatus.submiting;

      setState(() {
        _currentWord!.validate(_solution, updateKeyboard);

        _gameStatus = GameStatus.playing;
        _currentIndex++;
      });
    }
  }

  void updateKeyboard(Letter enteredLetter) {
    final keyToUpdate = specialKeys.firstWhere(
        (e) => e.val == enteredLetter.val,
        orElse: () => Letter.empty());

    if (keyToUpdate.status != LetterStatus.correct) {
      specialKeys.removeWhere((e) => e.val == enteredLetter.val);
      specialKeys.add(enteredLetter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(constants.appName),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          letterSpacing: 4,
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Board(board: _board),
            const SizedBox(height: constants.defaultPadding),
            Keyboard(
              onKeyTap: onKeyTap,
              onLimitedKeyTap: onLimitedKeyTap,
              onAccentTap: onAccentTap,
              onEnterTap: onEnterTap,
              onDeleteTap: onDeleteTap,
              specialKeys: specialKeys,
            ),
            const SizedBox(height: constants.defaultPadding / 2),
          ]),
          const AccentBox(),
        ],
      ),
    );
  }
}
