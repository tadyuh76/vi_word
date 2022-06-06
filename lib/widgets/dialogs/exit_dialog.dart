import 'package:flutter/material.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';

class ExitDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ExitDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kLayoutMaxWidth),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding),
              color: kDarkGrey,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kGrey,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darken(kGrey),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleButton(
                      isClose: true,
                      onTap: Navigator.of(context).pop,
                    ),
                    CircleButton(
                      isClose: false,
                      onTap: onTap,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatefulWidget {
  final bool isClose;
  final VoidCallback onTap;
  const CircleButton({
    Key? key,
    required this.isClose,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool isHover = false;
  Color get color => widget.isClose ? kRed : kPrimary;
  IconData get icon => widget.isClose ? Icons.close : Icons.check;
  String get text => widget.isClose ? 'Hủy' : 'OK';

  void enableHoverEffect(bool val) => setState(() => isHover = val);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onHover: enableHoverEffect,
          onHighlightChanged: (_) => enableHoverEffect(!isHover),
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1),
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHover ? color : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: Icon(
              icon,
              color: isHover ? Colors.white : color,
              size: 26,
            ),
          ),
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 16),
        )
      ],
    );
  }
}
