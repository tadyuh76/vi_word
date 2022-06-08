import 'package:flutter/material.dart';
import 'package:vi_word/screens/home_screen/home_screen.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';

class WonDialog extends StatelessWidget {
  final VoidCallback createNewGame;
  const WonDialog({Key? key, required this.createNewGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kLayoutMaxWidth),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'THẮNG RỒI!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                    Text(
                      'Bạn đã đoán được từ <solution> trong <guess> lượt thử!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(color: darken(kPrimary)),
                child: Row(
                  children: [
                    _CustomIconButton(
                      icon: Icons.home,
                      text: 'Trở về',
                      onTap: () => Navigator.of(context)
                          .popUntil(ModalRoute.withName(HomeScreen.routeName)),
                    ),
                    _CustomIconButton(
                      icon: Icons.repeat,
                      text: 'Chơi lại',
                      onTap: () {
                        Navigator.of(context).pop();
                        createNewGame();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _CustomIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 30),
              Text(
                ' $text',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
