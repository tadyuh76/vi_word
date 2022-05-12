import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';

enum LetterStatus { inittal, notInWord, wrongPosition, wrongAccent, correct }

class Letter {
  String val;
  LetterStatus status;

  Letter({required this.val, this.status = LetterStatus.inittal});

  factory Letter.empty() => Letter(val: '');

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.inittal:
        return Colors.transparent;
      case LetterStatus.correct:
        return primary;
      case LetterStatus.wrongAccent:
        return secondary;
      case LetterStatus.wrongPosition:
        return ternary;
      case LetterStatus.notInWord:
        return Colors.grey[700]!;
      default:
        return Colors.transparent;
    }
  }

  Color get borderColor {
    switch (status) {
      case LetterStatus.inittal:
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }

  void copyWith({String? val, LetterStatus? status}) {
    this.val = val ?? this.val;
    this.status = status ?? this.status;
  }
}
