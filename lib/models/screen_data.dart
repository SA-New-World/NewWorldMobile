import 'package:flutter/material.dart';

class ScreenData {
  String title;
  Icon icon;
  String iconLabel;
  Widget screen;

  ScreenData({
    required this.title,
    required this.icon,
    required this.iconLabel,
    required this.screen
  });
}