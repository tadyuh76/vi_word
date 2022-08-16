import 'package:flutter/material.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/color_changer.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/widgets/dialogs/yes_no_button.dart';

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
      insetPadding: const EdgeInsets.all(kDefaultPadding),
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: kLayoutMaxWidth),
          height: 300,
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
            mainAxisSize: MainAxisSize.min,
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
                  YesNoButton(
                    yes: true,
                    onTap: Navigator.of(context).pop,
                  ),
                  YesNoButton(
                    yes: false,
                    onTap: onTap,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
