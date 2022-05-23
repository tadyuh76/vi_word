import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:vi_word/screens/home_screen/play_button.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/widgets/scrren_background.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appName.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 48,
              color: Colors.white,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: kSecondary,
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding * 2),
          const PlayButton()
        ],
      )),
    );
  }
}
