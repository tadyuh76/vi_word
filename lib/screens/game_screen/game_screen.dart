import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/screens/game_screen/app_bar.dart';
import 'package:vi_word/services/audio_service.dart';
import 'package:vi_word/services/game_service.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/utils/enums.dart';
import 'package:vi_word/utils/show_snack_bar.dart';
import 'package:vi_word/widgets/accent_box.dart';
import 'package:vi_word/widgets/board.dart';
import 'package:vi_word/widgets/dialogs/tutorial_dialog.dart';
import 'package:vi_word/widgets/dialogs/won_dialog.dart';
import 'package:vi_word/widgets/keyboard.dart';
import 'package:vi_word/widgets/screen_background.dart';

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
  final _audioService = AudioService();

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

    _audioService.playSound(Sound.tapped);
  }

  void onLimitedKeyTap(String key) {
    if (_gameStatus != GameStatus.playing) return;

    showSnackBar(
      context: context,
      backgroundColor: kRed,
      text: 'Ch??? "$key" kh??ng c?? trong Ti???ng Vi???t !',
    );

    _audioService.playSound(Sound.tapped);
  }

  void onAccentTap(String valWithAccent) {
    setState(() {
      _currentWord!
        ..removeLetter()
        ..addLetter(valWithAccent);
    });

    _audioService.playSound(Sound.tapped);
  }

  void onDeleteTap() {
    if (_gameStatus != GameStatus.playing) return;

    setState(() => _currentWord?.removeLetter());

    _audioService.playSound(Sound.tapped);
  }

  Future<void> onEnterTap() async {
    if (_gameStatus != GameStatus.playing) return;

    if (_currentWord == null || _currentWord!.letters.any((e) => e.val == '')) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'B???n ch??a nh???p h???t t???!',
      );
    }

    bool inDictionary = _gameService.dictionaryHas(_currentWord!);
    if (!inDictionary) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'T??? n??y kh??ng c?? trong danh s??ch!',
      );
    }

    setState(() => _gameStatus = GameStatus.submitting);

    bool isCorrect = _gameService.validate(_currentWord!, _solution);
    bool isLost = _currentIndex == _board.length - 1;

    if (isCorrect) {
      Future.delayed(
        const Duration(milliseconds: 1200),
        () => showDialog(
          context: context,
          builder: (context) => WonDialog(
            createNewGame: () => createNewGame(context),
          ),
        ),
      );

      _gameStatus = GameStatus.won;
    } else if (isLost) {
      showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'T??? c???a ng??y h??m nay l?? $_solution',
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

    _audioService.playSound(Sound.flipCards);
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
        text: '???? kh???i t???o t??? m???i',
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
