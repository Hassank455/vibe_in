import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';

SizedBox verticalSpace(BuildContext context, double height) =>
    SizedBox(height: context.setHeight(height));

SizedBox horizontalSpace(BuildContext context, double width) =>
    SizedBox(width: context.setWidth(width));
