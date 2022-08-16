import 'package:hive/hive.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';
import 'package:vi_word/utils/enums.dart';
import 'package:vi_word/utils/hive_boxes.dart';

class CacheService {
  void cacheGameData({
    required List<Word> board,
    required String solution,
    required int currentIndex,
    required GameStatus gameStatus,
    required List<Letter> specialKeys,
  }) async {
    try {
      final box = await Hive.openBox(HiveBoxes.gameData);
      await box.put('board', board);
      await box.put('solution', solution);
      await box.put('currentIndex', currentIndex);
      await box.put('gameStatus', gameStatus);
      await box.put('specialKeys', specialKeys);
      print(box.values);
    } catch (e) {
      print('Error putting data: $e');
    }
  }
}
