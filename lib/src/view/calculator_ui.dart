import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calculator/src/utils/key_button_utils.dart';
import 'package:flutter_calculator/src/widgets/key_button.dart';

class CalculatorUI extends StatefulWidget {
  const CalculatorUI({super.key});

  @override
  State<CalculatorUI> createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  String input = "";
  bool isProgress = false;

  void onButtonTap(KeyButtonType type) {
    switch (type) {
      case KeyButtonType.delete:
        onBackButtonTap();
        return;
      case KeyButtonType.divide:
      case KeyButtonType.multiply:
      case KeyButtonType.minus:
      case KeyButtonType.plus:
        onSymbolButtonTap(type);
        return;
      case KeyButtonType.equal:
        onCalButtonTap();
      case KeyButtonType.deleteAll:
        onDeleteAllButton();
        return;
      default:
        onNumberButtonTap(type.label);
        return;
    }
  }

  void onDeleteAllButton() {
    setState(() {
      input = "";
      isProgress = false;
    });
  }

  void onNumberButtonTap(val) {
    setState(() {
      isProgress = true;
      input += val;
    });
  }

  void onSymbolButtonTap(KeyButtonType val) {
    final regex = RegExp(r'^(-?\d+(\.\d+)?)([+\-×÷])(-?\d+(\.\d+)?)$');
    final match = regex.firstMatch(input);
    if (match != null) return;
    setState(() {
      isProgress = true;
      if (input.isEmpty) {
        if (val == KeyButtonType.minus) {
          input = "-";
        } else {
          input += "0";
        }
      }

      final last = input[input.length - 1];

      String symbol;
      switch (val) {
        case KeyButtonType.divide:
          symbol = "÷";
          break;
        case KeyButtonType.multiply:
          symbol = "×";
          break;
        case KeyButtonType.minus:
          symbol = "-";
          break;
        case KeyButtonType.plus:
          symbol = "+";
          break;
        default:
          return;
      }

      if ('÷×+-'.contains(last)) {
        // 마지막이 연산자면 교체
        input = input.substring(0, input.length - 1) + symbol;
      } else {
        // 숫자거나 괄호 등이라면 그냥 추가
        input += symbol;
      }
    });
  }

  void onBackButtonTap() {
    if (input.isEmpty) return;
    setState(() {
      input = input.substring(0, input.length - 1);
    });
  }

  void onCalButtonTap() {
    final regex = RegExp(r'^(-?\d+(\.\d+)?)([+\-×÷])(-?\d+(\.\d+)?)$');
    final match = regex.firstMatch(input);
    if (match == null) return;

    final num1 = double.parse(match.group(1)!);
    final operator = match.group(3)!;
    final num2 = double.parse(match.group(4)!);
    var result = 0.0;
    setState(() {
      switch (operator) {
        case '+':
          result = (num1 + num2);
        case '-':
          result = (num1 - num2);
        case '×':
          result = (num1 * num2);
        case '÷':
          if (num2 == 0) {
            input = "정의되지 않음";
            return;
          } // 0으로 나누기 방지
          result = (num1 / num2);
        default:
          return;
      }
      input = result % 1 == 0 ? result.toInt().toString() : result.toString();
      isProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [buildCurrentValue(), ...buildButtons()],
          ),
        ),
      ),
    );
  }

  Widget buildCurrentValue() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // ← 오른쪽 끝부터 보이게!
              child: Text(
                input.isEmpty ? "0" : input,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildButtons() {
    final keys = [
      [
        KeyButtonType.seven,
        KeyButtonType.eight,
        KeyButtonType.nine,
        KeyButtonType.divide,
      ],
      [
        KeyButtonType.four,
        KeyButtonType.five,
        KeyButtonType.six,
        KeyButtonType.multiply,
      ],
      [
        KeyButtonType.one,
        KeyButtonType.two,
        KeyButtonType.three,
        KeyButtonType.minus,
      ],
      [
        KeyButtonType.equal,
        KeyButtonType.zero,
        isProgress ? KeyButtonType.delete : KeyButtonType.deleteAll,
        KeyButtonType.plus,
      ],
    ];
    return keys
        .map(
          (x) => Row(
            children:
                x
                    .map(
                      (y) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: KeyButton(type: y, onTap: onButtonTap),
                        ),
                      ),
                    )
                    .toList(),
          ),
        )
        .toList();
  }
}
