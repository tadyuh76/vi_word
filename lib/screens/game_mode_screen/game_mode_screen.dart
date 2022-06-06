import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vi_word/screens/game_screen/game_screen.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/widgets/screen_background.dart';

class GameModeScreen extends StatelessWidget {
  static const routeName = '/gamemode';
  const GameModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Lottie.asset(
                  'assets/game_console.json',
                  width: 160,
                  height: 160,
                ),
                const Text(
                  'Chọn chế độ chơi',
                  style: TextStyle(color: kGrey, fontSize: 24),
                ),
                const SizedBox(height: kDefaultPadding * 2),
                _GameModeButton(
                  title: 'Cổ điển',
                  subtitle: 'Một người chơi',
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(GameScreen.routeName),
                ),
                const SizedBox(height: kDefaultPadding),
                _GameModeButton(
                  title: 'Online',
                  subtitle: 'Nhiều người chơi',
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(GameScreen.routeName),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            top: kDefaultPadding,
            left: kDefaultPadding,
            child: InkWell(
              onTap: Navigator.of(context).pop,
              borderRadius: BorderRadius.circular(50),
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.chevron_left, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameModeButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _GameModeButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_GameModeButton> createState() => _GameModeButtonState();
}

class _GameModeButtonState extends State<_GameModeButton> {
  bool isHover = false;

  void enableHoverEffect(bool val) => setState(() => isHover = val);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 280,
      height: 80,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: isHover ? kPurple : kBackground,
        border: Border.all(color: kPurple),
        borderRadius: BorderRadius.circular(kDefaultPadding),
        boxShadow: const [BoxShadow(color: kPurple, blurRadius: 4)],
      ),
      child: InkWell(
        onTap: widget.onTap,
        onHover: enableHoverEffect,
        onHighlightChanged: enableHoverEffect,
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    color: kGrey,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            alignment: Alignment.center,
            child: Icon(
              Icons.chevron_right,
              color: isHover ? kGrey : kMediumGrey,
              size: 32,
            ),
          )
        ]),
      ),
    );
  }
}
