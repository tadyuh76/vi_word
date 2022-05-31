import 'package:flutter/material.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';

class TabItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;
  const TabItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: icon,
            onPressed: onTap,
            iconSize: 60,
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              color: kMediumGrey,
              fontSize: 16,
              letterSpacing: 1,
            ),
          )
        ],
      ),
    );
  }
}
