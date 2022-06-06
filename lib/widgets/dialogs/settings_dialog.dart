import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vi_word/utils/breakpoints.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/widgets/custom_close_button.dart';
import 'package:vi_word/widgets/custom_switch.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kLayoutMaxWidth),
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: kDarkGrey,
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/settings.svg',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: kDefaultPadding,
                  ),
                  const Text(
                    'SETTINGS',
                    style: TextStyle(
                      color: kGrey,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  const CustomCloseButton(),
                ],
              ),
              const Divider(
                color: kMediumGrey,
                height: kDefaultPadding,
              ),
              _SettingsItem(
                text: 'NHẠC NỀN',
                onTap: (active) {
                  print("nhạc nền: $active");
                },
              ),
              const Divider(
                color: kMediumGrey,
                height: kDefaultPadding,
              ),
              _SettingsItem(
                text: 'HIỆU ỨNG ÂM THANH',
                onTap: (active) {
                  print("sfx: $active");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatefulWidget {
  final void Function(bool) onTap;
  final String text;

  const _SettingsItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<_SettingsItem> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              color: kGrey,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          CustomSwitch(onTap: widget.onTap),
        ],
      ),
    );
  }
}
