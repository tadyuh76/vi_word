import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/enums.dart';

part 'letter.g.dart';

@HiveType(typeId: 0)
class Letter {
  @HiveField(0)
  String val;
  @HiveField(1)
  LetterStatus status;

  Letter({required this.val, this.status = LetterStatus.initial});

  factory Letter.empty() => Letter(val: '');

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.correct:
        return kCorrectColor.withAlpha(220);
      case LetterStatus.wrongAccent:
        return kWrongAccentColor.withAlpha(220);
      case LetterStatus.wrongPosition:
        return kWrongPositionColor.withAlpha(220);
      case LetterStatus.notInWord:
        return kMediumGrey;
      case LetterStatus.initial:
        return Colors.transparent;
      default:
        return kMediumGrey;
    }
  }

  Color get borderColor {
    switch (status) {
      case LetterStatus.correct:
        return kCorrectColor;
      case LetterStatus.wrongAccent:
        return kWrongAccentColor;
      case LetterStatus.wrongPosition:
        return kWrongPositionColor;
      default:
        return kMediumGrey;
    }
  }

  Letter copyWith({String? val, LetterStatus? status}) {
    this.val = val ?? this.val;
    this.status = status ?? this.status;

    return this;
  }
}
