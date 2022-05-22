import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import '../../utils/colors.dart';

AppBar renderAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 3,
    shadowColor: kPrimary,
    leading: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: GestureDetector(
        onTap: () {},
        child: const FaIcon(
          FontAwesomeIcons.chevronLeft,
          size: 24,
        ),
      ),
    ),
    actions: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: kDefaultPadding),
        child: GestureDetector(
          onTap: () {},
          child: const FaIcon(
            FontAwesomeIcons.circleQuestion,
            size: 30,
          ),
        ),
      )
    ],
    title: const Text(constants.appName),
    centerTitle: true,
    titleTextStyle: const TextStyle(
        letterSpacing: 4,
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: kPrimary,
            blurRadius: 8,
            spreadRadius: 4,
          )
        ]),
  );
}
