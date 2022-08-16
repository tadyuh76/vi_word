import 'package:flutter/material.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';

class YesNoButton extends StatefulWidget {
  final bool yes;
  final VoidCallback onTap;
  const YesNoButton({
    Key? key,
    required this.yes,
    required this.onTap,
  }) : super(key: key);

  @override
  State<YesNoButton> createState() => _YesNoButtonState();
}

class _YesNoButtonState extends State<YesNoButton> {
  bool isHover = false;
  Color get color => widget.yes ? kRed : kCorrectColor;
  IconData get icon => widget.yes ? Icons.close : Icons.check;
  String get text => widget.yes ? 'Hủy' : 'OK';

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
