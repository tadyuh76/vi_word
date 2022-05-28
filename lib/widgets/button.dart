import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:vi_word/utils/colors.dart';

class Button extends StatelessWidget {
  final Color borderColor;
  final Color textColor;
  final String text;
  final VoidCallback onTap;
  const Button({
    Key? key,
    required this.borderColor,
    required this.textColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: 0.6 * constraints.maxWidth,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: kTernary, width: 3),
            borderRadius: BorderRadius.circular(5),
            color: kBackground,
            boxShadow: [
              BoxShadow(
                color: borderColor,
                blurRadius: 30,
                inset: true,
              ),
              BoxShadow(
                color: borderColor,
                blurRadius: 20,
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                shadows: [
                  Shadow(
                    color: textColor,
                    blurRadius: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
