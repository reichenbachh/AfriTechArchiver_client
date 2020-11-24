import 'package:flutter/material.dart';

Color colorConvert(String color) {
  color = color.replaceAll("#", "");
  Color convertedValue;
  if (color.length == 6) {
    convertedValue = Color(int.parse("0xFF" + color));
  } else if (color.length == 8) {
    convertedValue = Color(int.parse("0x" + color));
  }
  return convertedValue;
}
