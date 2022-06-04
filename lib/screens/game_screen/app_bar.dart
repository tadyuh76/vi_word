import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vi_word/screens/home_screen/home_screen.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import 'package:vi_word/widgets/exit_dialog.dart';
import 'package:vi_word/widgets/tutorial_dialog.dart';

AppBar renderAppBar(
  BuildContext context,
  void Function(BuildContext) createNewGame,
) {
  return AppBar(
    backgroundColor: kBackground.withOpacity(0.8),
    elevation: 3,
    centerTitle: true,
    title: const Text(constants.appName),
    titleTextStyle: const TextStyle(
      letterSpacing: 4,
      fontSize: 28,
      color: kSecondary,
      fontWeight: FontWeight.bold,
      fontFamily: 'Quicksand',
      shadows: [
        Shadow(
          color: kSecondary,
          blurRadius: 4,
        )
      ],
    ),
    leading: Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (context) => ExitDialog(
            title: 'Bạn có chắc chắn muốn thoát ?',
            subtitle: 'Tiến độ trò chơi hiện tại sẽ không được lưu',
            onTap: () => Navigator.of(context).popUntil(
              ModalRoute.withName(HomeScreen.routeName),
            ),
          ),
        ),
        child: const FaIcon(
          FontAwesomeIcons.chevronLeft,
          size: 20,
          color: kGrey,
        ),
      ),
    ),
    actions: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => ExitDialog(
              title: 'Bạn có chắc chắn muốn chơi lại ?',
              subtitle: 'Tiến độ trò chơi sẽ được làm mới',
              onTap: () {
                Navigator.of(context).pop();
                createNewGame(context);
              },
            ),
          ),
          child: const FaIcon(
            FontAwesomeIcons.repeat,
            size: 20,
            color: kGrey,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: kDefaultPadding),
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            barrierColor: kBackground.withOpacity(0.3),
            builder: (context) => const TutorialDialog(),
          ),
          child: const FaIcon(
            FontAwesomeIcons.circleQuestion,
            size: 22,
            color: kGrey,
          ),
        ),
      )
    ],
  );
}
