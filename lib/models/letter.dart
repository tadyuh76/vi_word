import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';

enum LetterStatus { initial, notInWord, wrongPosition, wrongAccent, correct }

class Letter {
  String val;
  LetterStatus status;

  Letter({required this.val, this.status = LetterStatus.initial});

  factory Letter.empty() => Letter(val: '');

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.initial:
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
      case LetterStatus.initial:
        return Colors.grey[700]!;
      default:
        return Colors.transparent;
    }
  }

  Letter copyWith({String? val, LetterStatus? status}) {
    this.val = val ?? this.val;
    this.status = status ?? this.status;

    return this;
  }

  @override
  String toString() {
    return "{val: $val, status: $status}";
  }
}
