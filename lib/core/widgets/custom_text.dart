import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle? style;

  CustomText({
    required this.text,
    this.textAlign,
    this.maxLines,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '-',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      textScaleFactor: 1,
      style: style ?? Theme.of(context).textTheme.headlineSmall,
    );
  }
}
