import 'package:flutter/material.dart';
import 'package:vi_word/screens/game_screeen/game_screen.dart';
import 'package:vi_word/widgets/max_width_container.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MaxWidthContainer(child: GameScreen()),
    );
  }
}
