import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vi_word/models/letter.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/utils/enums.dart';
import 'package:vi_word/widgets/board_tile.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog({Key? key}) : super(key: key);

  final _normalStyle = const TextStyle(
    color: kGrey,
    // fontFamily: 'Qu',
    fontFamily: 'Quicksand',
    fontSize: 18,
  );
  final _boldStyle = const TextStyle(
    color: kGrey,
    fontWeight: FontWeight.bold,
    fontFamily: 'Quicksand',
    // fontFamily: 'Montserrat',
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(kDefaultPadding),
      child: Container(
        width: double.infinity,
        height: size.height * 0.95,
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: kDarkGrey,
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/notebook.svg',
                  width: 36,
                  height: 36,
                ),
                const SizedBox(width: kDefaultPadding),
                const Text(
                  'HƯỚNG DẪN',
                  style: TextStyle(color: kGrey, fontSize: 20),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Container(
                    width: 36,
                    height: 36,
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: kMediumGrey, width: 1),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: kGrey,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              color: kMediumGrey,
              height: kDefaultPadding,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Đoán từ ',
                            style: _normalStyle,
                          ),
                          TextSpan(
                            text: appName,
                            style: _boldStyle,
                          ),
                          TextSpan(
                            text:
                                ' trong 6 lượt thử.\n\nMỗi lượt đoán phải là một từ có nghĩa gồm 6 chữ cái. Từ này có thể có một hoặc nhiều tiếng. Nhấn biểu tượng mũi tên để kiểm tra từ bạn đoán đã đúng hay chưa.\n\nSau mỗi lượt đoán, màu của các ô chữ sẽ thay đổi để thể hiện độ chính xác của từ bạn đoán với đáp án.',
                            style: _normalStyle,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                        color: kMediumGrey, height: kDefaultPadding * 2),
                    Text('Ví dụ:', style: _boldStyle),
                    _WordRow(
                      letters: [
                        Letter(val: 'đ', status: LetterStatus.correct),
                        Letter(val: 'e'),
                        Letter(val: 'n'),
                        Letter(val: 't'),
                        Letter(val: 'ố'),
                        Letter(val: 'i')
                      ],
                      text1: 'Chữ',
                      text2: 'Đ',
                      text3: 'có trong đáp án và đang ở đúng vị trí.',
                    ),
                    _WordRow(
                      letters: [
                        Letter(val: 'd'),
                        Letter(val: 'a', status: LetterStatus.wrongAccent),
                        Letter(val: 'd'),
                        Letter(val: 'i'),
                        Letter(val: 'ế'),
                        Letter(val: 't')
                      ],
                      text1: 'Chữ',
                      text2: 'A',
                      text3:
                          'có trong đáp án và đang ở đúng vị trí nhưng mang sai dấu.',
                    ),
                    _WordRow(
                      letters: [
                        Letter(val: 'c'),
                        Letter(val: 'o'),
                        Letter(val: 'n'),
                        Letter(val: 'c'),
                        Letter(val: 'á', status: LetterStatus.wrongPosition),
                        Letter(val: 'o')
                      ],
                      text1: 'Chữ',
                      text2: 'A (không xét dấu của chữ này)',
                      text3: 'có trong đáp án nhưng đang ở sai vị trí.',
                    ),
                    _WordRow(
                      letters: [
                        Letter(val: 'á', status: LetterStatus.notInWord),
                        Letter(val: 'o', status: LetterStatus.notInWord),
                        Letter(val: 'b'),
                        Letter(val: 'a', status: LetterStatus.notInWord),
                        Letter(val: 'l'),
                        Letter(val: 'ỗ', status: LetterStatus.notInWord)
                      ],
                      text1: 'Chữ',
                      text2: 'A, O',
                      text3: 'không có trong đáp án.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WordRow extends StatelessWidget {
  final List<Letter> letters;
  final String text1;
  final String text2;
  final String text3;

  const _WordRow(
      {Key? key,
      required this.letters,
      required this.text1,
      required this.text2,
      required this.text3})
      : super(key: key);

  final _normalStyle = const TextStyle(
    color: kGrey,
    fontFamily: 'Quicksand',
    // fontFamily: 'Montserrat',
    fontSize: 18,
  );
  final _boldStyle = const TextStyle(
    fontFamily: 'Quicksand',
    // fontFamily: 'Montserrat',
    color: kGrey,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double letterSize =
        width > kLayoutMaxWidth ? 50 : (width - 6 * kDefaultPadding) / 6 - 8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: letters
                .map((e) => BoardTile(letter: e, size: letterSize))
                .toList(),
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text1,
                style: _normalStyle,
              ),
              TextSpan(
                text: ' $text2 ',
                style: _boldStyle,
              ),
              TextSpan(
                text: text3,
                style: _normalStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}
