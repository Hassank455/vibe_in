import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_colors.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: AppColors.mainBrown,
    // scaffoldBackgroundColor: AppColors.white,
    // // canvasColor: AppColors.lightWhiteColor,
    // cardColor: AppColors.white,

    // textTheme: TextTheme(
    //   titleSmall: getRegularStyle(),
    //   titleMedium: getMediumStyle(),
    //   titleLarge: getLargeStyle(),
    //   headlineSmall: getSemiBoldStyle(),
    //   headlineMedium: getBoldStyle(),
    //   headlineLarge: getBoldStyle(),
    // ),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: AppColors.white,
    //   contentPadding: EdgeInsets.symmetric(
    //       vertical: AppSize.s18.h, horizontal: AppSize.s16.w),
    //   hintStyle: getRegularStyle().copyWith(color: AppColors.darkWhite),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8.r),
    //     borderSide:
    //         BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
    //   ),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8.r),
    //     borderSide:
    //         BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide:
    //         BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide:
    //         BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide:
    //         BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
    //   ),
    // ),
    // appBarTheme: AppBarTheme(
    //   iconTheme: const IconThemeData(
    //     color: AppColors.normalBlack,
    //   ),
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    //   centerTitle: true,
    //   titleTextStyle: getBoldStyle(fontSize: AppSize.s16),
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness:
    //         Platform.isAndroid ? Brightness.dark : Brightness.light,
    //     statusBarBrightness:
    //         Platform.isAndroid ? Brightness.dark : Brightness.light,
    //   ),
    //   // titleTextStyle: getBoldStyle().copyWith(color: AppColors.darkFontColors),
    //   // actionsIconTheme: const IconThemeData(
    //   //   color: AppColors.darkFontColors,
    //   // ),
    // ),
    // // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    // //     selectedLabelStyle: TextStyle(
    // //         fontWeight: FontWeight.w400,
    // //         color: AppColors.selectNavBar,
    // //         fontSize: 14,
    // //         fontFamily: FontConstants.fontFamily),
    // //     unselectedLabelStyle: TextStyle(
    // //         fontWeight: FontWeight.w400,
    // //         color: AppColors.unselectNavBar,
    // //         fontSize: 14,
    // //         fontFamily: FontConstants.fontFamily),
    // //     showUnselectedLabels: true,
    // //     selectedItemColor: AppColors.selectNavBar),

    // // drawerTheme:
    // //     const DrawerThemeData(backgroundColor: AppColors.lightMainColor),
    // // appBarTheme: const AppBarTheme(
    // //   iconTheme: IconThemeData(
    // //     color: AppColors.darkFontColors,
    // //   ),
    // //   backgroundColor: Colors.transparent,
    // //   elevation: 0,
    // //   centerTitle: true,
    // //   titleTextStyle: TextStyle(color: AppColors.darkFontColors),
    // //   actionsIconTheme: IconThemeData(
    // //     color: AppColors.darkFontColors,
    // //   ),
    // // ),
    // // tabBarTheme: TabBarTheme(
    // //   unselectedLabelStyle: TextStyle(
    // //       color: const Color(0xFFBEBFD8),
    // //       fontSize: 16.sp,
    // //       fontFamily: /*SharedPreferencesController().languageCode == 'ar'
    // //           ? ''
    // //           : */
    // //           FontConstants.fontFamily,
    // //       fontWeight: FontWeight.w400),
    // //   indicator: UnderlineTabIndicator(
    // //       borderSide: BorderSide(
    // //         color: AppColors.lightMainColor,
    // //         width: 3.w,
    // //         style: BorderStyle.solid,
    // //       ),
    // //       insets: EdgeInsets.symmetric(horizontal: 15.w)),
    // //   unselectedLabelColor: const Color(0xFFBEBFD8),
    // //   labelColor: AppColors.lightMainColor,
    // //   indicatorSize: TabBarIndicatorSize.tab,
    // //   labelStyle: TextStyle(
    // //     color: AppColors.lightMainColor,
    // //     fontSize: 16.sp,
    // //     fontWeight: FontWeight.w400,
    // //     fontFamily: /*SharedPreferencesController().languageCode == 'ar'
    // //         ? ''
    // //         : */
    // //         FontConstants.fontFamily,
    // //   ),
    // // ),
    // // dividerTheme: const DividerThemeData(color: Colors.transparent),
    // // dividerColor: Colors.transparent,
    // // primaryColorDark: const Color(0xFFEFF1F5),
    // // // indicatorColor: AppColors.lightLine,

    // iconTheme: const IconThemeData(color: AppColors.black),
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: AppColors.mainBrown,
//     scaffoldBackgroundColor: AppColors.darkBackGroundColor,
//     // canvasColor: AppColors.darkCanvasColor,
//     cardColor: AppColors.darkCardColor,

//     appBarTheme: AppBarTheme(
//       iconTheme: const IconThemeData(
//         color: AppColors.darkWhite,
//       ),
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle:
//           getBoldStyle(fontSize: AppSize.s16, color: AppColors.darkFont),
//       surfaceTintColor: Colors.transparent,
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness:
//             Platform.isAndroid ? Brightness.light : Brightness.dark,
//         statusBarBrightness:
//             Platform.isAndroid ? Brightness.light : Brightness.dark,
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColors.darkCardColor,
//       contentPadding: EdgeInsets.symmetric(
//           vertical: AppSize.s18.h, horizontal: AppSize.s16.w),
//       hintStyle: getRegularStyle().copyWith(color: AppColors.darkWhite),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8.r),
//         borderSide:
//             BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8.r),
//         borderSide:
//             BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8),
//         borderSide:
//             BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8),
//         borderSide:
//             BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8),
//         borderSide:
//             BorderSide(color: AppColors.lightActiveBlack, width: AppSize.s1.w),
//       ),
//     ),
// //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
// //         selectedLabelStyle: TextStyle(
// //           fontWeight: FontWeight.w400,
// //           color: AppColors.selectNavBar,
// //           fontSize: 14,
// //           fontFamily: FontConstants.fontFamily,
// //         ),
// //         unselectedLabelStyle: TextStyle(
// //           fontWeight: FontWeight.w400,
// //           color: AppColors.unselectNavBar,
// //           fontSize: 14,
// //           fontFamily: FontConstants.fontFamily,
// //         ),
// //         showUnselectedLabels: true,
// //         selectedItemColor: AppColors.darkFontMain),
// //     drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFC5215A)),
// // //      scaffoldBackgroundColor: AppColors.darkBackGroundColor,
// //     dividerTheme: const DividerThemeData(
// //       color: Colors.transparent,
// //       thickness: 0,
// //     ),
// //     dividerColor: Colors.transparent,
//     // scaffoldBackgroundColor: AppColors.darkMainColor,
//     // appBarTheme: AppBarTheme(
//     //   backgroundColor: Colors.transparent,
//     //   elevation: 0,
//     //   centerTitle: true,
//     //   titleTextStyle: TextStyle(color: AppColors.lightFontColors),
//     //   actionsIconTheme: IconThemeData(
//     //     color: AppColors.lightFontColors,
//     //   ),
//     // ),
//     // tabBarTheme: TabBarTheme(
//     //   unselectedLabelStyle: TextStyle(
//     //     color: const Color(0xFFFFFFFF).withOpacity(0.3),
//     //     fontSize: 16.sp,
//     //     fontWeight: FontWeight.w400,
//     //     fontFamily: FontConstants.fontFamily,
//     //   ),
//     //   indicator: UnderlineTabIndicator(
//     //       borderSide: BorderSide(
//     //         color: const Color(0xFFC71F51),
//     //         width: 3.w,
//     //         style: BorderStyle.solid,
//     //       ),
//     //       insets: EdgeInsets.symmetric(horizontal: 15.w)),
//     //   unselectedLabelColor: const Color(0xFFFFFFFF).withOpacity(0.3),
//     //   labelColor: const Color(0xFFC71F51),
//     //   indicatorSize: TabBarIndicatorSize.tab,
//     //   labelStyle: TextStyle(
//     //     color: const Color(0xFFC71F51),
//     //     fontSize: 16.sp,
//     //     fontWeight: FontWeight.w400,
//     //     fontFamily: FontConstants.fontFamily,
//     //   ),
//     // ),
//     textTheme: TextTheme(
//       titleSmall: getRegularStyle().copyWith(color: AppColors.darkFont),
//       titleMedium: getMediumStyle().copyWith(color: AppColors.darkFont),
//       titleLarge: getLargeStyle().copyWith(color: AppColors.darkFont),
//       headlineSmall: getSemiBoldStyle().copyWith(color: AppColors.darkFont),
//       headlineMedium: getBoldStyle().copyWith(color: AppColors.darkFont),
//       headlineLarge: getBoldStyle().copyWith(color: AppColors.darkFont),
//     ),

//     // primaryColorDark: const Color(0xFF1D2228),
//     // indicatorColor: AppColors.lightBoxShadow,
//     // iconTheme: const IconThemeData(color: AppColors.white),
  );
}