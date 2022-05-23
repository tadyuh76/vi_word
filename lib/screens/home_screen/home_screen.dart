import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/screens/game_screeen/game_screen.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kDarkGrey,
              kBackground,
            ],
            begin: Alignment(-.7, -1),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              Button(
                borderColor: kTernary,
                
                textColor: kSecondary,
                text: "PLAY",
                onTap: () =>
                    Navigator.of(context).pushNamed(GameScreen.routeName),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Button(
                borderColor: kTernary,
                textColor: kTernary,
                text: "ONLINE",
                onTap: () =>
                    Navigator.of(context).pushNamed(GameScreen.routeName),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Button(
                borderColor: kTernary,
                textColor: kTernary,
                text: "MORE",
                onTap: () =>
                    Navigator.of(context).pushNamed(GameScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
