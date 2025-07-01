import 'package:flutter/material.dart';

class SizeProvider extends InheritedWidget {
  final Size baseSize;
  final double width;
  final double height;
  const SizeProvider({
    Key? key,
    required Widget child,
    required this.baseSize,
    required this.width,
    required this.height,
  }) : super(key: key, child: child);

  /// take the context and search for size provider
  static SizeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;
  }

  /// should rebuild widget or not
  @override
  bool updateShouldNotify(covariant SizeProvider oldWidget) {
    return baseSize != oldWidget.baseSize ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        child != oldWidget.child;
  }
}
