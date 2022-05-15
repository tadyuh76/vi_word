import 'package:vi_word/models/letter.dart';
import 'package:vi_word/models/word.dart';

const String appName = 'Vi Word';

// game constants
const enterKey = 'enter';
const delKey = 'del';
const keyRows = [
  ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
  [delKey, 'z', 'x', 'c', 'v', 'b', 'n', 'm', enterKey],
];
final List<Word> initBoard = List.generate(
  6,
  (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
);

final Map<String, List<List<String>>> keyWithAccents = {
  'a': [
    ['', 'á', 'à', 'ả', 'ã', 'ạ'],
    ['â', 'ấ', 'ầ', 'ẩ', 'ẫ', 'ậ'],
    ['ă', 'ắ', 'ằ', 'ẳ', 'ẵ', 'ặ'],
  ],
  'e': [
    ['', 'é', 'è', 'ẻ', 'ẽ', 'ẹ'],
    ['ê', 'ế', 'ề', 'ể', 'ễ', 'ệ'],
  ],
  'i': [
    ['', 'í', 'ì', 'ỉ', 'ĩ', 'ị'],
  ],
  'o': [
    ['', 'ó', 'ò', 'ỏ', 'õ', 'ọ'],
    ['ô', 'ố', 'ồ', 'ổ', 'ỗ', 'ộ'],
    ['ơ', 'ớ', 'ờ', 'ở', 'ỡ', 'ỡ'],
  ],
  'u': [
    ['', 'ú', 'ù', 'ủ', 'ũ', 'ụ'],
    ['ư', 'ứ', 'ừ', 'ử', 'ữ', 'ự'],
  ],
};
