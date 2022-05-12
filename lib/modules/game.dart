import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';

class Game {
  static final List<Word> initBoard = List.generate(
    6,
    (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
  );
}
