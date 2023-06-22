import 'package:flutter/material.dart';

TextStyle kCustomText({
  double fontSize = 16.0,
  required Color color,
  FontWeight fontWeight = FontWeight.normal, Paint? foreground
}) =>
    TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight
    );
