import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';

class CustomSwitch extends StatefulWidget {
  final void Function(bool) onTap;
  const CustomSwitch({Key? key, required this.onTap}) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        active = !active;
        widget.onTap(active);
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 60,
        height: 30,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: active ? kPurple : kMediumGrey,
        ),
        child: AnimatedPadding(
          padding: EdgeInsets.only(left: active ? 30 : 0),
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? kSecondary : kGrey,
            ),
          ),
        ),
      ),
    );
  }
}
