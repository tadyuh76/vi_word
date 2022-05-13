import 'package:vi_word/models/models.dart';

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

  void validate(String solution, void Function(Letter) callback) {
    for (int i = 0; i < letters.length; i++) {
      final currentWordLetter = letters[i];
      final currentSolutionLetter = solution[i];

      if (currentWordLetter.val == currentSolutionLetter) {
        currentWordLetter.copyWith(status: LetterStatus.correct);
      } else if (solution.contains(currentWordLetter.val)) {
        currentWordLetter.copyWith(status: LetterStatus.wrongPosition);
      } else {
        currentWordLetter.copyWith(status: LetterStatus.notInWord);
      }

      callback(currentWordLetter);
    }
  }
}
