import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/screens/game_screen/app_bar.dart';
import 'package:vi_word/services/cache_service.dart';
// import 'package:vi_word/services/audio_service.dart';
import 'package:vi_word/services/game_service.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/utils/enums.dart';
import 'package:vi_word/utils/hive_boxes.dart';
import 'package:vi_word/utils/show_snack_bar.dart';
import 'package:vi_word/widgets/dialogs/end_dialog.dart';
import 'package:vi_word/widgets/dialogs/tutorial_dialog.dart';
import 'package:vi_word/widgets/game/accent_box.dart';
import 'package:vi_word/widgets/game/board.dart';
import 'package:vi_word/widgets/keyboard/keyboard.dart';
import 'package:vi_word/widgets/screen_background.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Box<dynamic> gameDataCacheBox = Hive.box(HiveBoxes.gameData);
  final _flipCardControllers = GameService().initFlipCardControllers;
  final _gameService = GameService();
  final _cacheService = CacheService();
  // final _audioService = AudioService();

  List<Word> _board = [];
  int _currentIndex = 0;
  String _solution = '';
  GameStatus _gameStatus = GameStatus.playing;
  List<Letter> specialKeys = [];

  bool accentBoxVisible = false;
  Word? get _currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    checkAlreadyPlayed();
    initGame();
  }

  void initGame() {
    try {
      _board = gameDataCacheBox
          .get('board', defaultValue: GameService().initBoard)
          .cast<Word>();
      _currentIndex = gameDataCacheBox.get('currentIndex', defaultValue: 0);
      _gameStatus =
          gameDataCacheBox.get('gameStatus', defaultValue: GameStatus.playing);
      _solution = gameDataCacheBox.get('solution',
          defaultValue: GameService().getWordOfTheDay());
      specialKeys =
          gameDataCacheBox.get('specialKeys', defaultValue: []).cast<Letter>();

      for (int i = 0; i < _currentIndex; i++) {
        _gameService.flipWordRow(_flipCardControllers[i]);
      }
    } catch (e) {
      print('Error initializing game: $e');
    }
  }

  void checkAlreadyPlayed() async {
    try {
      // Why I have to open this box which was already opened ??
      await Hive.openBox(HiveBoxes.gameData);

      final alreadyPlayed =
          gameDataCacheBox.get('alreadyPlayed', defaultValue: false);
      if (alreadyPlayed) return;

      showDialog(
        context: context,
        builder: (context) => const TutorialDialog(),
      );
      gameDataCacheBox.put('alreadyPlayed', true);
      // box.close();
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

    // _audioService.playSound(Sound.tapped);
  }

  void onLimitedKeyTap(String key) {
    if (_gameStatus != GameStatus.playing) return;

    showSnackBar(
      context: context,
      backgroundColor: kRed,
      text: 'Chữ "$key" không có trong Tiếng Việt !',
    );

    // _audioService.playSound(Sound.tapped);
  }

  void onAccentTap(String valWithAccent) {
    setState(() {
      _currentWord!
        ..removeLetter()
        ..addLetter(valWithAccent);
    });

    // _audioService.playSound(Sound.tapped);
  }

  void onDeleteTap() {
    if (_gameStatus != GameStatus.playing) return;

    setState(() => _currentWord?.removeLetter());

    // _audioService.playSound(Sound.tapped);
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

    bool inDictionary = _gameService.dictionaryHas(_currentWord!);
    if (!inDictionary) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Từ này không có trong danh sách!',
      );
    }

    setState(() => _gameStatus = GameStatus.submitting);

    bool isCorrect = _gameService.validate(_currentWord!, _solution);
    bool isLost = _currentIndex == _board.length - 1;

    if (isCorrect) {
      Future.delayed(
        const Duration(milliseconds: 1500),
        () => showDialog(
          context: context,
          builder: (context) => EndDialog(
            createNewGame: () => createNewGame(context),
            solution: _solution,
            guesses: _currentIndex,
          ),
        ),
      );

      _gameStatus = GameStatus.won;
    } else if (isLost) {
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
    _gameService.flipWordRow(_flipCardControllers[_currentIndex++]);
    _cacheService.cacheGameData(
      board: _board,
      solution: _solution,
      currentIndex: _currentIndex,
      gameStatus: _gameStatus,
      specialKeys: specialKeys,
    );

    // _audioService.playSound(Sound.flipCards);
    setState(() {});
  }

  void createNewGame([BuildContext? context]) {
    _board = _gameService.initBoard;
    _solution = _gameService.getWordOfTheDay();
    _currentIndex = 0;
    _gameStatus = GameStatus.playing;
    specialKeys = [];

    for (final row in _flipCardControllers) {
      for (final controller in row) {
        controller.controller?.reset();
      }
    }

    if (context != null) {
      showSnackBar(
        context: context,
        backgroundColor: darken(kWrongAccentColor, 0.05),
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
      onTap: () => setState(() => accentBoxVisible = false),
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
