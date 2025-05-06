import 'dart:math';

import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension MarginSymmetric on Widget {
  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget marginOnly(
      {double start = 0, double top = 0, double end = 0, double bottom = 0}) {
    return Padding(
      padding:
          EdgeInsetsDirectional.only(start: start, top: top, end: end, bottom: bottom),
      child: this,
    );
  }

  Widget marginAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget paddingOnly(
      {double start = 0, double top = 0, double end = 0, double bottom = 0}) {
    return Padding(
      padding:
          EdgeInsetsDirectional.only(start: start, top: top, end: e, bottom: bottom),
      child: this,
    );
  }
}
extension WidgetExtensions on Widget {
  Widget withKey(Key key) => KeyedSubtree(key: key, child: this);
}