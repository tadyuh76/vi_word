import 'package:vi_word/models/letter.dart';

class Word {
  final List<Letter> letters;

  Word({required this.letters});

  factory Word.fromString(String str) {
    return Word(letters: str.split('').map((e) => Letter(val: e)).toList());
  }

  String wordString() => letters.map((e) => e.val).join('');

  void addLetter(String val) {
    final currentIndex = letters.indexWhere((element) => element.val.isEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(val: val);
    }
  }

  void removeLetter() {
    final lastLetterIndex =
        letters.lastIndexWhere((element) => element.val.isNotEmpty);
    if (lastLetterIndex != -1) {
      letters[lastLetterIndex] = Letter.empty();
    }
  }
}
