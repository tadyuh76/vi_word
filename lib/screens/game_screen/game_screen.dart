import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/screens/game_screen/app_bar.dart';
import 'package:vi_word/services/game_service.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/utils/enums.dart';
import 'package:vi_word/utils/show_snack_bar.dart';
import 'package:vi_word/widgets/accent_box.dart';
import 'package:vi_word/widgets/board.dart';
import 'package:vi_word/widgets/keyboard.dart';
import 'package:vi_word/widgets/screen_background.dart';
import 'package:vi_word/widgets/tutorial_dialog.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<List<FlipCardController>> _flipCardControllers =
      GameService().initFlipCardControllers;
  final _gameService = GameService();

  Word? get _currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;

  int _currentIndex = 0;
  GameStatus _gameStatus = GameStatus.playing;
  bool accentBoxVisible = false;

  late List<Word> _board;
  late String _solution;
  late Set<Letter> specialKeys;

  @override
  void initState() {
    super.initState();

    createNewGame();
    checkAlreadyPlayed();
  }

  Future<void> checkAlreadyPlayed() async {
    try {
      final box = Hive.box('gameData');
      final alreadyPlayed = await box.get('alreadyPlayed');
      if (alreadyPlayed == true) return;

      showDialog(context: context, builder: (_) => const TutorialDialog());
      box.put('alreadyPlayed', true);
    } catch (e) {
      debugPrint('error checking alreadyPlayed: ${e.toString()}');
    }
  }

  void onKeyTap(String key) {
    if (_gameStatus != GameStatus.playing) return;

    setState(() {
      bool? added = _currentWord?.addLetter(key);

      if (keyWithAccents.containsKey(key) && added == true) {
        accentBoxVisible = true;
      }
    });
  }

  void onLimitedKeyTap(String key) {
    if (_gameStatus != GameStatus.playing) return;

    showSnackBar(
      context: context,
      backgroundColor: kRed,
      text: 'Chữ "$key" không có trong Tiếng Việt !',
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
    if (_gameStatus != GameStatus.playing) return;

    setState(() => _currentWord?.removeLetter());
  }

  Future<void> onEnterTap() async {
    if (_gameStatus != GameStatus.playing) return;

    if (_currentWord == null || _currentWord!.letters.any((e) => e.val == '')) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Bạn chưa nhập hết từ!',
      );
    }

    bool isVietnamese = _gameService.checkVietnamese(_currentWord!);
    if (!isVietnamese) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Từ này không có trong danh sách!',
      );
    }

    setState(() => _gameStatus = GameStatus.submitting);

    bool isCorrect = _gameService.validate(_currentWord!, _solution);

    if (isCorrect) {
      showSnackBar(
        context: context,
        backgroundColor: kPrimary,
        text: 'Bạn đã hoàn thành từ của ngày hôm nay !',
      );
      _gameStatus = GameStatus.won;
    } else if (_currentIndex == _board.length - 1) {
      showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Từ của ngày hôm nay là $_solution',
      );
      _gameStatus = GameStatus.lost;
    } else {
      _gameStatus = GameStatus.playing;
    }

    _gameService.updateKeyboard(_currentWord!, specialKeys);
    _gameService.flipCards(
      _currentWord!,
      _flipCardControllers[_currentIndex++],
    );

    setState(() {});
  }

  void createNewGame([BuildContext? context]) {
    _board = _gameService.initBoard;
    _solution = _gameService.getWordOfTheDay();
    _currentIndex = 0;
    _gameStatus = GameStatus.playing;
    specialKeys = {};

    for (final row in _flipCardControllers) {
      for (final controller in row) {
        controller.controller?.reset();
      }
    }

    if (context != null) {
      showSnackBar(
        context: context,
        backgroundColor: darken(kSecondary, 0.05),
        text: 'Đã khởi tạo từ mới',
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Letter lastLetter =
        _currentWord != null ? _currentWord!.lastLetter : Letter.empty();

    return GestureDetector(
      onTap: () => Future.delayed(const Duration(milliseconds: 400),
          () => setState(() => accentBoxVisible = false)),
      child: Scaffold(
        appBar: renderAppBar(context, createNewGame),
        body: ScreenBackground(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: kDefaultPadding / 2),
                  Board(
                    board: _board,
                    flipCardControllers: _flipCardControllers,
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
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
                keyVal: lastLetter.val,
                visible: accentBoxVisible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
