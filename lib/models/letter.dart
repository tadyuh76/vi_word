import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/enums.dart';

class Letter {
  String val;
  LetterStatus status;

  Letter({required this.val, this.status = LetterStatus.initial});

  factory Letter.empty() => Letter(val: '');

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.correct:
        return kPrimary.withAlpha(220);
      case LetterStatus.wrongAccent:
        return kSecondary.withAlpha(230);
      case LetterStatus.wrongPosition:
        return kTernary.withAlpha(220);
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
        return kPrimary;
      case LetterStatus.wrongAccent:
        return kSecondary;
      case LetterStatus.wrongPosition:
        return kTernary;
      case LetterStatus.notInWord:
        return kMediumGrey;
      default:
        return kMediumGrey;
    }
  }

  Letter copyWith({String? val, LetterStatus? status}) {
    this.val = val ?? this.val;
    this.status = status ?? this.status;

    return this;
  }

  @override
  String toString() {
    return "($val, $status)";
  }
}
