/// {@category Menu model}
import 'package:flutter/cupertino.dart';

class NavigationOption {
  NavigationOption({
    required this.title,
    required this.page,
  });

  final Widget page;
  final String title;
}
