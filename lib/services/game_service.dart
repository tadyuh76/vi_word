import 'package:flip_card/flip_card_controller.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/utils/remove_diacritics.dart';

class GameService {
  static final List<Word> initBoard = List.generate(
    6,
    (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
  );

  static final List<List<FlipCardController>> initFlipCardControllers =
      List.generate(
    6,
    (index) => List.generate(6, (index) => FlipCardController()),
  );

  bool validate(
    Word word,
    String solution,
    Set<Letter> specialKeys,
  ) {
    int correct = 0;
    final letters = word.letters;
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

      updateKeyboard(currentWordLetter, specialKeys);
    }
    return correct == letters.length;
  }

  void updateKeyboard(Letter enteredLetter, Set<Letter> specialKeys) {
    final removedAccentLetterVal = removeDiacritics(enteredLetter.val);
    final keyToUpdate = specialKeys.firstWhere(
        (e) => e.val == removedAccentLetterVal,
        orElse: () => Letter.empty());

    if (keyToUpdate.status != LetterStatus.correct) {
      specialKeys.removeWhere((e) => e.val == removedAccentLetterVal);
      specialKeys.add(Letter(
        val: removedAccentLetterVal,
        status: enteredLetter.status,
      ));
    }
  }

  void flipCards(
      Word currentWord, List<FlipCardController> flipCardControllers) {
<<<<<<< HEAD
    currentWord!.letters.asMap().forEach((i, element) async {
=======
    currentWord.letters.asMap().forEach((i, element) async {
>>>>>>> 4ccdac8 (refactor code and redesign app ui)
      await Future.delayed(Duration(milliseconds: (i + 1) * 200),
          () => flipCardControllers[i].toggleCard());
    });
  }
}
