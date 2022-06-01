import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
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
      fontSize: 32,
      color: Colors.white,
      shadows: [
        Shadow(
          color: kSecondary,
          blurRadius: 4,
        )
      ],
    ),
    leading: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const FaIcon(
          FontAwesomeIcons.chevronLeft,
          size: 24,
          color: kGrey,
        ),
      ),
    ),
    actions: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => createNewGame(context),
          child: const FaIcon(
            FontAwesomeIcons.repeat,
            size: 30,
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
            size: 30,
            color: kGrey,
          ),
        ),
      )
    ],
  );
}
