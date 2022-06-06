import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vi_word/screens/home_screen/home_screen.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart' as constants;
import 'package:vi_word/widgets/dialogs/exit_dialog.dart';
import 'package:vi_word/widgets/dialogs/tutorial_dialog.dart';

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
      fontSize: 28,
      color: kSecondary,
      fontWeight: FontWeight.bold,
      fontFamily: 'Quicksand',
      shadows: [
        Shadow(
          color: kSecondary,
          blurRadius: 4,
        )
      ],
    ),
    leading: _AppBarButton(
      icon: Icons.chevron_left,
      iconSize: 32,
      onTap: () => showDialog(
        context: context,
        builder: (context) => ExitDialog(
          title: 'Bạn có chắc chắn muốn thoát ?',
          subtitle: 'Tiến độ trò chơi hiện tại sẽ không được lưu',
          onTap: () => Navigator.of(context).popUntil(
            ModalRoute.withName(HomeScreen.routeName),
          ),
        ),
      ),
    ),
    actions: [
      _AppBarButton(
        icon: FontAwesomeIcons.repeat,
        iconSize: 22,
        onTap: () => showDialog(
          context: context,
          builder: (context) => ExitDialog(
            title: 'Bạn có chắc chắn muốn chơi lại ?',
            subtitle: 'Tiến độ trò chơi sẽ được làm mới',
            onTap: () {
              Navigator.of(context).pop();
              createNewGame(context);
            },
          ),
        ),
      ),
      _AppBarButton(
        icon: FontAwesomeIcons.circleQuestion,
        iconSize: 24,
        onTap: () => showDialog(
          context: context,
          barrierColor: kBackground.withOpacity(0.3),
          builder: (context) => const TutorialDialog(),
        ),
      ),
    ],
  );
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double iconSize;

  const _AppBarButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(right: kDefaultPadding / 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: FaIcon(
            icon,
            color: kGrey,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
