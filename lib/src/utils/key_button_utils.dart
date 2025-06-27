import 'package:flutter/cupertino.dart';

enum KeyButtonType {
  zero("0"),
  one("1"),
  two("2"),
  three("3"),
  four("4"),
  five("5"),
  six("6"),
  seven("7"),
  eight("8"),
  nine("9"),

  delete(Icon(CupertinoIcons.delete_left, size: 30)),
  deleteAll("AC"),
  divide(Icon(CupertinoIcons.divide, size: 30, color: Color(0xfff3f3f3))),
  multiply(Icon(CupertinoIcons.multiply, size: 30, color: Color(0xfff3f3f3))),
  minus(Icon(CupertinoIcons.minus, size: 30, color: Color(0xfff3f3f3))),
  plus(Icon(CupertinoIcons.plus, size: 30, color: Color(0xfff3f3f3))),
  equal(Icon(CupertinoIcons.equal, size: 30));

  const KeyButtonType(this.label);
  final dynamic label;
}
