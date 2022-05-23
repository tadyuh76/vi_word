import 'package:flutter/material.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/screens/game_screeen/app_bar.dart';
import 'package:vi_word/services/game_service.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import 'package:vi_word/utils/show_snack_bar.dart';
import 'package:vi_word/widgets/accent_box.dart';
import 'package:vi_word/widgets/board.dart';
import 'package:vi_word/widgets/keyboard.dart';

enum GameStatus { playing, won, lost, submiting }

class GameScreen extends StatefulWidget {
  static const routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _gameService = GameService();
  final _board = GameService.initBoard;
  final _flipCardControllers = GameService.initFlipCardControllers;
  final Set<Letter> specialKeys = {};

  int _currentIndex = 0;
  GameStatus _gameStatus = GameStatus.playing;
  bool accentBoxVisible = false;

  Word? get _currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;
  String get _solution => _gameService.getWordOfTheDay();

  @override
  void dispose() {
    super.dispose();
    _flipCardControllers.forEach(
      (element) => element.forEach(
        (e) => e.controller!.dispose(),
      ),
    );
  }

  void onKeyTap(String key) {
    if (_gameStatus == GameStatus.playing) {
      setState(() {
        bool? added = _currentWord?.addLetter(key);

        // if the key can have accents
        if (constants.keyWithAccents.keys.contains(key)) {
          accentBoxVisible = added ?? false;
        }
      });
    }
  }

  void onLimitedKeyTap(String key) {
    showSnackBar(
      context: context,
      backgroundColor: kRed,
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

  Future<void> onEnterTap() async {
    if (_gameStatus != GameStatus.playing) {
      return;
    }
    if (_currentWord == null || _currentWord!.letters.any((e) => e.val == '')) {
      showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Bạn chưa nhập hết từ!',
      );
      return;
    }

    setState(() {
      _gameStatus = GameStatus.submiting;

      bool isVietnamese = _gameService.checkVietnamese(_currentWord!);
      if (!isVietnamese) {
        showSnackBar(
          context: context,
          backgroundColor: kRed,
          text: 'Từ này không có trong tiếng Việt !',
        );
        _gameStatus = GameStatus.playing;
        return;
      }

      bool isCorrect =
          _gameService.validate(_currentWord!, _solution, specialKeys);
      if (isCorrect) {
        showSnackBar(
          context: context,
          backgroundColor: kPrimary,
          text: 'You won !',
        );
        _gameStatus = GameStatus.won;
      } else if (_currentIndex == _board.length - 1) {
        showSnackBar(
          context: context,
          backgroundColor: kRed,
          text: 'You lost',
        );
        _gameStatus = GameStatus.lost;
      } else {
        _gameStatus = GameStatus.playing;
      }

      _gameService.flipCards(
        _currentWord!,
        _flipCardControllers[_currentIndex++],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Letter lastLetter =
        _currentWord != null ? _currentWord!.lastLetter : Letter.empty();

    return GestureDetector(
      onTap: () => setState(() => accentBoxVisible = false),
      child: Scaffold(
        appBar: renderAppBar(context),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: kDefaultPadding / 2),
                Board(
                  board: _board,
                  flipCardControllers: _flipCardControllers,
                ),
                Keyboard(
                  onKeyTap: onKeyTap,
                  onLimitedKeyTap: onLimitedKeyTap,
                  onEnterTap: onEnterTap,
                  onDeleteTap: onDeleteTap,
                  specialKeys: specialKeys,
                ),
                const SizedBox(height: kDefaultPadding / 2),
              ],
            ),
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
