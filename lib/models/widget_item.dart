import 'package:flutter/material.dart';

class WidgetCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final int widgetCount;
  final Widget screen;

  const WidgetCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.widgetCount,
    required this.screen,
  });
}
