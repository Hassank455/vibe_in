import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';

// هي extension methods تساعدك تحوّل الأرقام الثابتة (من Figma) لأرقام تتناسب مع حجم الشاشة الحالي.
// 📌 هذه تستخدم النسبة بين deviceSize و baseSize لحساب التحجيم المناسب.
// لو الشاشة الفعلية أطول من التصميم، فـ setHeight يعطيك أكبر من 20.
// لو الشاشة أصغر، يعطيك أصغر من 20.
extension SizerHelperExtension on BuildContext {
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenWidth =>
      isLandscape
          ? MediaQuery.of(this).size.height
          : MediaQuery.of(this).size.width;

  double get screenHeight =>
      isLandscape
          ? MediaQuery.of(this).size.width
          : MediaQuery.of(this).size.height;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  // لما يكون عندك تصميم على Figma مثلاً بحجم شاشة 393 × 852 (الـ baseSize)، لكن التطبيق راح يشتغل على شاشات مختلفة (مثلاً تابلت 800 × 1280)، نحتاج نحسب نسبة التحجيم علشان نخلي التصميم يظل متناسق مهما كانت الشاشة.

  // نسبة العرض الفعلي إلى عرض التصميم الأساسي.
  double get scaleWidth => sizeProvider.width / sizeProvider.baseSize.width;
  // actualScreenWidth = 393
  // baseScreenWidth = 393
  // scale width = 393 / 393 = 1
  // 	•	إذا scaleWidget = 2.0، كل عنصر في التصميم بيتضاعف عرضه على التابلت.
  // •	إذا scaleWidget = 0.81، العناصر بتصغر شوي على الأجهزة الصغيرة.
  //?---------
  // نسبة الطول الفعلي إلى طول التصميم الأساسي.
  double get scaleHeight => sizeProvider.height / sizeProvider.baseSize.height;
  // actualScreenHeight = 1280
  // baseScreenHeight = 852
  // scale height = 1280 / 852 = 1.5
  // •	scaleHight = 1.5 → العناصر الرأسية مثل height أو marginTop راح تزيد نسبتها على الأجهزة الكبيرة.
  // •	scaleHight = 0.7 → العناصر تتقلص رأسيًا على الأجهزة الصغيرة.
  //?---------

  // عدد الـ logical pixels المناسب لحجم الشاشة الحالي، بناءً على التصميم

  double setWidth(num w) {
    return w * scaleWidth;
  }
  // نفس الشيء لكن على الارتفاع
  double setHeight(num h) {
    return h * scaleHeight;
  }

  double setSp(num sp) {
    return sp * scaleWidth;
  }

  // •	عندما تريد عنصر يبقى متناسق شكله في العرض والارتفاع مهما اختلف حجم الشاشة.
  // •	BorderRadius.circular() ✅
  // •	padding العام (غير مخصص عرض أو ارتفاع فقط) ✅
  // •	fontSize إذا كنت تفضل توازن بين العرض والارتفاع ✅
  // •	Icon size ✅
  // •	CircleAvatar, shimmer box, square button
  double setMinSize(num size) {
    return size * min(scaleWidth, scaleHeight);
  }
}
