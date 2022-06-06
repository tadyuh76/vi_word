import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vi_word/screens/home_screen/play_button.dart';
import 'package:vi_word/screens/home_screen/tab_item.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';
import 'package:vi_word/widgets/dialogs/settings_dialog.dart';
import 'package:vi_word/widgets/screen_background.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 48,
                    color: kPurple,
                    letterSpacing: 4,
                    shadows: [
                      BoxShadow(
                        color: kPurple,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const PlayButton(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TabItem(
                      onTap: () {},
                      icon: SvgPicture.asset('assets/icons/profile.svg'),
                      text: "HỒ SƠ",
                    ),
                    TabItem(
                      onTap: () {},
                      icon: SvgPicture.asset('assets/icons/diamond.svg'),
                      text: "THÊM",
                    ),
                    TabItem(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => const SettingsDialog(),
                      ),
                      icon: SvgPicture.asset('assets/icons/settings.svg'),
                      text: "CÀI ĐẶT",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
