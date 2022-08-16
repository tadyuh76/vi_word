import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 2)
enum GameStatus {
  @HiveField(0)
  playing,
  @HiveField(1)
  won,
  @HiveField(2)
  lost,
  @HiveField(3)
  submitting,
}

@HiveType(typeId: 3)
enum LetterStatus {
  @HiveField(0)
  initial,
  @HiveField(1)
  notInWord,
  @HiveField(2)
  wrongPosition,
  @HiveField(3)
  wrongAccent,
  @HiveField(4)
  correct,
}

enum Sound { tapped, flipCards, background }
