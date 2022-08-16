// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStatusAdapter extends TypeAdapter<GameStatus> {
  @override
  final int typeId = 2;

  @override
  GameStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GameStatus.playing;
      case 1:
        return GameStatus.won;
      case 2:
        return GameStatus.lost;
      case 3:
        return GameStatus.submitting;
      default:
        return GameStatus.playing;
    }
  }

  @override
  void write(BinaryWriter writer, GameStatus obj) {
    switch (obj) {
      case GameStatus.playing:
        writer.writeByte(0);
        break;
      case GameStatus.won:
        writer.writeByte(1);
        break;
      case GameStatus.lost:
        writer.writeByte(2);
        break;
      case GameStatus.submitting:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LetterStatusAdapter extends TypeAdapter<LetterStatus> {
  @override
  final int typeId = 3;

  @override
  LetterStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LetterStatus.initial;
      case 1:
        return LetterStatus.notInWord;
      case 2:
        return LetterStatus.wrongPosition;
      case 3:
        return LetterStatus.wrongAccent;
      case 4:
        return LetterStatus.correct;
      default:
        return LetterStatus.initial;
    }
  }

  @override
  void write(BinaryWriter writer, LetterStatus obj) {
    switch (obj) {
      case LetterStatus.initial:
        writer.writeByte(0);
        break;
      case LetterStatus.notInWord:
        writer.writeByte(1);
        break;
      case LetterStatus.wrongPosition:
        writer.writeByte(2);
        break;
      case LetterStatus.wrongAccent:
        writer.writeByte(3);
        break;
      case LetterStatus.correct:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
