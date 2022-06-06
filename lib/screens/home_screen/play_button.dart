import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vi_word/screens/game_mode_screen/game_mode_screen.dart';
import 'package:vi_word/utils/colors.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool isHover = false;

  void enableHoverEffect(bool val) => setState(() => isHover = val);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: kPink,
      endRadius: 160.0,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(GameModeScreen.routeName),
        borderRadius: BorderRadius.circular(100),
        onHighlightChanged: enableHoverEffect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 160,
          height: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isHover ? kPink : kBackground,
            border: Border.all(color: kPink, width: 4),
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(color: kPink, blurRadius: 10),
              BoxShadow(color: kPink, blurRadius: 20, inset: true),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              'assets/icons/play.svg',
              color: Colors.white,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
