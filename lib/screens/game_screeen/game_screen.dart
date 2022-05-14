import 'package:flutter/material.dart';
import 'package:vi_word/models/models.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import 'package:vi_word/utils/remove_diacritics.dart';
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
  bool accentBoxVisible = false;

  Word? get _currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;
  String get _solution => 'bánhmì';

  final Set<Letter> specialKeys = {};

  void onKeyTap(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() {
        bool? added = _currentWord?.addLetter(val);
        if (constants.keyWithAccents.keys.contains(val)) {
          accentBoxVisible = added ?? false;
        }
      });
    }
  }

  void onLimitedKeyTap(String key) {
    showSnackBar(
      context: context,
      backgroundColor: red,
      text: 'Chữ $key không có trong Tiếng Việt !',
    );
  }

  void onAccentTap(String valWithAccent) {
    setState(() {
      _currentWord!
        ..removeLetter()
        ..addLetter(valWithAccent);
    });
  }

  void onDeleteTap() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  void onEnterTap() {
    if (_gameStatus == GameStatus.playing &&
        _currentWord != null &&
        _currentWord!.letters.every((e) => e.val != '')) {
      setState(() {
        bool isCorrect = _currentWord!.validate(_solution, updateKeyboard);
        if (isCorrect) {
          showSnackBar(
            context: context,
            backgroundColor: primary,
            text: 'You won !',
            duration: const Duration(days: 1),
          );
          _gameStatus = GameStatus.won;
        } else if (_currentIndex == _board.length - 1) {
          showSnackBar(
            context: context,
            backgroundColor: red,
            text: 'You lost',
            duration: const Duration(days: 1),
          );
          _gameStatus = GameStatus.lost;
        } else {
          _gameStatus = GameStatus.playing;
          _currentIndex++;
        }
      });
    } else {
      showSnackBar(
        context: context,
        backgroundColor: red,
        text: 'Bạn chưa nhập hết từ!',
      );
    }
  }

  void updateKeyboard(Letter enteredLetter) {
    final removedAccentLetterVal = removeDiacritics(enteredLetter.val);
    final keyToUpdate = specialKeys.firstWhere(
        (e) => e.val == removedAccentLetterVal,
        orElse: () => Letter.empty());

    if (keyToUpdate.status != LetterStatus.correct) {
      specialKeys.removeWhere((e) => e.val == removedAccentLetterVal);
      specialKeys.add(Letter(
        val: removedAccentLetterVal,
        status: enteredLetter.status,
      ));
      print(specialKeys);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Letter lastLetter =
        _currentWord != null ? _currentWord!.lastLetter : Letter.empty();

    return GestureDetector(
      onTap: () => setState(() => accentBoxVisible = false),
      child: Scaffold(
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
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Board(board: _board),
                  const SizedBox(height: constants.defaultPadding),
                  Keyboard(
                    onKeyTap: onKeyTap,
                    onLimitedKeyTap: onLimitedKeyTap,
                    onEnterTap: onEnterTap,
                    onDeleteTap: onDeleteTap,
                    specialKeys: specialKeys,
                  ),
                  const SizedBox(height: constants.defaultPadding / 2),
                ]),
            AccentBox(
              onTap: onAccentTap,
              visible: accentBoxVisible,
              keyVal: lastLetter.val,
            ),
          ],
        ),
      ),
    );
  }
}
