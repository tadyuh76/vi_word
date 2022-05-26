import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.8,
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: const BoxDecoration(color: kDarkGrey),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
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
            ),
            const Divider(
              color: kMediumGrey,
              height: kDefaultPadding * 2,
            )
          ],
        ),
      ),
    );
  }
}
