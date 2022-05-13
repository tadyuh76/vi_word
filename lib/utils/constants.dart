import 'package:vi_word/models/models.dart';

const String appName = 'Vi Word';
const double defaultPadding = 20;

// game constants
const enterKey = 'enter';
const delKey = 'del';
const keyRows = [
  ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
  [delKey, 'z', 'x', 'c', 'v', 'b', 'n', 'm', enterKey],
];
final List<Word> initBoard = List.generate(
  6,
  (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
);
