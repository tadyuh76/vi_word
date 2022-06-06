import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';

class CustomCloseButton extends StatefulWidget {
  const CustomCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCloseButton> createState() => _CustomCloseButtonState();
}

class _CustomCloseButtonState extends State<CustomCloseButton> {
  bool isHover = false;

  void enableHoverEffect(bool val) => setState(() => isHover = !isHover);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: Navigator.of(context).pop,
        onHighlightChanged: enableHoverEffect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: kMediumGrey, width: 1),
            color: isHover ? kMediumGrey : Colors.transparent,
          ),
          child: Icon(
            Icons.close,
            color: isHover ? Colors.white : kGrey,
            size: 20,
          ),
        ),
      ),
    );
  }
}
