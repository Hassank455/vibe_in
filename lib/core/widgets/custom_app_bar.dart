import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final List<Widget>? actions;
  final double? toolbarHeight;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const CustomAppBar({
    super.key,
    this.text,
    this.actions,
    this.toolbarHeight,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          text == null
              ? null
              : CustomText(
                text: text,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: Theme.of(context).appBarTheme.elevation,
      centerTitle: Theme.of(context).appBarTheme.centerTitle,
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      toolbarHeight:
          toolbarHeight ?? Theme.of(context).appBarTheme.toolbarHeight,
      actions: actions,
    );
  }

  // Set preferred size based on toolbarHeight or fallback to default AppBar height
  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
