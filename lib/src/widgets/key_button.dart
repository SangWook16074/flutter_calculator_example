import 'package:flutter/material.dart';
import 'package:flutter_calculator/src/utils/key_button_utils.dart';

class KeyButton extends StatelessWidget {
  final KeyButtonType type;
  final ValueSetter<KeyButtonType>? onTap;
  const KeyButton({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    buildChild() {
      switch (type) {
        case KeyButtonType.delete:
        case KeyButtonType.divide:
        case KeyButtonType.multiply:
        case KeyButtonType.minus:
        case KeyButtonType.plus:
        case KeyButtonType.equal:
          return type.label;
        default:
          return Text(
            type.label,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          );
      }
    }

    buildColor() {
      switch (type) {
        case KeyButtonType.divide:
        case KeyButtonType.multiply:
        case KeyButtonType.minus:
        case KeyButtonType.plus:
          return Color(0xff6457FC);

        default:
          return Theme.of(context).colorScheme.onSecondary;
      }
    }

    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(type);
        }
      },
      borderRadius: BorderRadius.circular(28.0),
      splashColor: Color(0xffffffff).withAlpha((255.0 * 0.5).round()),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Ink(
          decoration: BoxDecoration(
            color: buildColor(),
            borderRadius: BorderRadius.circular(28.0),
          ),

          child: Center(child: buildChild()),
        ),
      ),
    );
  }
}
