import 'package:vi_word/models/letter.dart';

class Word {
  final List<Letter> letters;

  Word({required this.letters});

  factory Word.fromString(String str) {
    return Word(letters: str.split('').map((e) => Letter(val: e)).toList());
  }

  Letter get lastLetter {
    return letters.lastWhere(
      (element) => element.val != '',
      orElse: Letter.empty,
    );
  }

  String wordString() => letters.map((e) => e.val).join('');

  bool addLetter(String val) {
    bool added = false;
    final currentIndex = letters.indexWhere((element) => element.val.isEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(val: val);
      added = true;
    }
    return added;
  }

  void removeLetter() {
    final lastLetterIndex =
        letters.lastIndexWhere((element) => element.val.isNotEmpty);
    if (lastLetterIndex != -1) {
      letters[lastLetterIndex] = Letter.empty();
    }
  }

  @override
  String toString() {
    return 'Word($letters)';
  }
}
