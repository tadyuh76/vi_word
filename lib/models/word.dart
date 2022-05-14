import 'package:vi_word/models/models.dart';
import 'package:vi_word/utils/remove_diacritics.dart';

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

  bool validate(String solution, void Function(Letter) callback) {
    int correct = 0;
    for (int i = 0; i < letters.length; i++) {
      final currentWordLetter = letters[i];
      final currentSolutionLetter = solution[i];

      if (currentWordLetter.val == currentSolutionLetter) {
        correct++;
        currentWordLetter.copyWith(status: LetterStatus.correct);
      } else if (removeDiacritics(currentSolutionLetter) ==
          removeDiacritics(currentWordLetter.val)) {
        currentWordLetter.copyWith(status: LetterStatus.wrongAccent);
      } else if (removeDiacritics(solution)
          .contains(removeDiacritics(currentWordLetter.val))) {
        currentWordLetter.copyWith(status: LetterStatus.wrongPosition);
      } else {
        currentWordLetter.copyWith(status: LetterStatus.notInWord);
      }

      callback(currentWordLetter);
    }
    return correct == letters.length;
  }
}
