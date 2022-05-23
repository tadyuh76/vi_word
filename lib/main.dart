import 'package:flutter/material.dart';
import 'package:vi_word/screens/game_screeen/game_screen.dart';
import 'package:vi_word/screens/home_screen/home_screen.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/widgets/max_width_container.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaxWidthContainer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: kBackground),
      ),
    );
  }
}
