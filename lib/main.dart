import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vi_word/screens/game_mode_screen/game_mode_screen.dart';
import 'package:vi_word/screens/game_screen/game_screen.dart';
import 'package:vi_word/screens/home_screen/home_screen.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/widgets/max_width_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('gameData');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaxWidthContainer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Quicksand')
            .copyWith(scaffoldBackgroundColor: kBackground),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          GameModeScreen.routeName: (context) => const GameModeScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
