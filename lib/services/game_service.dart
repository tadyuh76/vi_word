import 'dart:math';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/resources/words.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/utils/enums.dart';
import 'package:vi_word/utils/remove_diacritics.dart';

class GameService {
  final _statusPriority = {
    LetterStatus.initial: 0,
    LetterStatus.notInWord: 1,
    LetterStatus.wrongPosition: 2,
    LetterStatus.wrongAccent: 3,
    LetterStatus.correct: 4,
  };

  List<Word> get initBoard => List.generate(
        numberOfGuess,
        (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
      );

  List<List<FlipCardController>> get initFlipCardControllers => List.generate(
        numberOfGuess,
        (_) => List.generate(6, (_) => FlipCardController()),
      );

  String getWordOfTheDay() {
    // final now = DateTime.now();
    // final todayInDays = now.difference(DateTime(now.year, 1, 1, 0, 0)).inDays;
    // return words[todayInDays + (now.year - 2022) * 366];

    final random = Random();
    final randomIdx = random.nextInt(words.length);
    debugPrint('Today word is: ${words[randomIdx]}');
    return words[randomIdx];
  }

  bool dictionaryHas(Word word) {
    return words.contains(word.wordString());
  }

  bool validate(Word word, String solution) {
    int correct = 0;
    final letters = word.letters;
    String remainLettersToCheck = solution;

    // check for correct and wrong accent keys
    for (int i = 0; i < letters.length; i++) {
      final Letter currentWordLetter = letters[i];
      final String currentSolutionLetter = solution[i];

      bool isCorrect = currentWordLetter.val == currentSolutionLetter;
      bool isWrongAccent = removeDiacritics(currentSolutionLetter) ==
          removeDiacritics(currentWordLetter.val);

      if (isCorrect) {
        correct++;
        remainLettersToCheck =
            remainLettersToCheck.replaceFirst(remainLettersToCheck[i], ' ', i);
        currentWordLetter.copyWith(status: LetterStatus.correct);
      } else if (isWrongAccent) {
        remainLettersToCheck =
            remainLettersToCheck.replaceFirst(remainLettersToCheck[i], ' ', i);
        currentWordLetter.copyWith(status: LetterStatus.wrongAccent);
      } else {
        currentWordLetter.copyWith(status: LetterStatus.notInWord);
      }
    }

    // check for wrong position keys
    for (int i = 0; i < letters.length; i++) {
      final Letter guessLetter = letters[i];
      final String solutionLetter = solution[i];
      final String rdGuessLetter = removeDiacritics(guessLetter.val);

      bool isCorrect = guessLetter.val == solutionLetter;
      bool isWrongAccent = removeDiacritics(solutionLetter) == rdGuessLetter;
      bool isWrongPosition =
          removeDiacritics(remainLettersToCheck).contains(rdGuessLetter);

      if (isWrongPosition && !isCorrect && !isWrongAccent) {
        final indexToReplace =
            removeDiacritics(remainLettersToCheck).indexOf(rdGuessLetter);

        remainLettersToCheck = remainLettersToCheck.replaceFirst(
            remainLettersToCheck[indexToReplace], ' ');
        guessLetter.copyWith(status: LetterStatus.wrongPosition);
      }
    }

    return correct == letters.length;
  }

  void updateKeyboard(Word enteredWord, List<Letter> specialKeys) {
    for (Letter enteredLetter in enteredWord.letters) {
      final removedAccentLetterVal = removeDiacritics(enteredLetter.val);
      final currentSavedKey = specialKeys.firstWhere(
          (e) => e.val == removedAccentLetterVal,
          orElse: () => Letter.empty());

      if (_statusPriority[enteredLetter.status]! >
          _statusPriority[currentSavedKey.status]!) {
        specialKeys.removeWhere((e) => e.val == removedAccentLetterVal);
        specialKeys.add(Letter(
          val: removedAccentLetterVal,
          status: enteredLetter.status,
        ));
      }
    }
  }

  void flipWordRow(List<FlipCardController> flipCardControllers) {
    flipCardControllers.asMap().forEach((i, element) async {
      await Future.delayed(Duration(milliseconds: i * 150),
          () => flipCardControllers[i].toggleCard());
    });
  }
}
