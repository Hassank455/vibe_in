import 'package:flutter/material.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CustomText(text: 'Scan Screen')));
  }
}
