import 'package:flutter/material.dart';
import 'package:vi_word/utils/colors.dart';
import 'package:vi_word/utils/constants.dart';

const _enterKey = 'enter';
const _delKey = 'del';

var _keyRows = [
  ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
  [_delKey, 'z', 'x', 'c', 'v', 'b', 'n', 'm', _enterKey],
];

class Keyboard extends StatefulWidget {
  final void Function(String) onKeyTap;
  final VoidCallback onEnterTap, onDeleteTap;
  const Keyboard({
    Key? key,
    required this.onKeyTap,
    required this.onEnterTap,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    final keyWidth = (MediaQuery.of(context).size.width - defaultPadding) /
            _keyRows[0].length -
        4;

    return Positioned(
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        child: Column(
          children: _keyRows
              .map(
                (row) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.map((key) {
                    if (key == _enterKey) {
                      return _KeyboardButton.enter(
                        onTap: widget.onEnterTap,
                        width: keyWidth * 1.5,
                        height: keyWidth * 1.3,
                      );
                    } else if (key == _delKey) {
                      return _KeyboardButton.delete(
                        onTap: widget.onDeleteTap,
                        width: keyWidth * 1.5,
                        height: keyWidth * 1.3,
                      );
                    } else {
                      return _KeyboardButton(
                        keyVal: key,
                        onTap: () => widget.onKeyTap(key),
                        height: keyWidth * 1.3,
                        width: keyWidth,
                        backgroundColor: Colors.grey[600],
                      );
                    }
                  }).toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final VoidCallback onTap;
  final double height;
  final double width;
  final String? keyVal;
  final Color? backgroundColor;
  final Icon? icon;

  const _KeyboardButton({
    Key? key,
    this.icon,
    this.keyVal,
    required this.height,
    required this.width,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  factory _KeyboardButton.enter({onTap, width, height}) {
    return _KeyboardButton(
      keyVal: _enterKey,
      onTap: onTap,
      width: width,
      height: height,
      backgroundColor: Colors.grey[600],
      icon: const Icon(
        Icons.arrow_right,
        color: primary,
        size: 36,
      ),
    );
  }

  factory _KeyboardButton.delete({onTap, width, height}) {
    return _KeyboardButton(
      keyVal: _delKey,
      onTap: onTap,
      width: width,
      height: height,
      backgroundColor: Colors.grey[600],
      icon: const Icon(
        Icons.delete,
        color: red,
        size: 36,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(4),
        ),
        child: icon ?? Text(keyVal!),
      ),
    );
  }
}
