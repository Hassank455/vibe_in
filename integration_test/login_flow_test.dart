import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login -> OTP -> HomeScreen', (tester) async {
    app.main(initialRouteOverride: Routes.loginScreen);
    await tester.pumpAndSettle();
    print('✅ App launched');

    final phoneField = find.byKey(const Key('phone_field'));
    await tester.pumpUntilFound(phoneField);
    await tester.enterText(phoneField, '512345678');
    // يُستخدم pumpAndSettle() لانتظار انتهاء كل الـ animations أو الـ async rebuilds في الشاشة قبل الانتقال للخطوة التالية.
    // ❌ لما يكون غير مفيد (أو يسبب تعليق):
    // •	في حالة استخدام FutureBuilder أو BlocListener أو Navigator.pushNamed()، أحيانًا ما يكفي pumpAndSettle() لأنه ينتظر كل frames تستقر، ولو في animation طول الوقت أو إعادة بناء، يعلق.
    // •	لو وضعت pumpAndSettle() بعد tap() مباشرة، وكان التنقل يحتاج وقت أطول (زي انتظار API ثم Navigator)، ممكن ما يلحق يعرض الشاشة الجديدة قبل الانتقال.
    await tester.pumpAndSettle();
    print('✅ Phone entered');

    final loginButton = find.byKey(const Key('login_button_click'));
    await tester.tap(loginButton);
    // await tester.pumpAndSettle();
    print('✅ Login button tapped');

    // ⏳ انتظر شاشة OTP تظهر
    // لأنك تعتمد على التنقل إلى شاشة جديدة (OTP) بعد استجابة ناجحة من API، عبر Bloc
    // “يا Flutter، انتظر حتى فعلاً يظهر هذا العنصر على الشاشة، بعدها كمّل!”
    await tester.pumpUntil(
      () => find.byKey(const Key('otp_field')).evaluate().isNotEmpty,
      timeout: const Duration(seconds: 10),
    );
    print('✅ OTP screen navigated');

    final editableText = find.descendant(
      of: find.byKey(const Key('otp_field')),
      matching: find.byType(EditableText),
    );
    await tester.tap(editableText);
    // await tester.pumpAndSettle();
    await tester.enterText(editableText, '1234');
    // await tester.pumpAndSettle();
    print('✅ OTP entered');

    final verifyButton = find.byKey(const Key('verify_button'));
    await tester.tap(verifyButton);

    // await tester.pumpUntil(
    //   () => find.text(AppStrings.bestSeller.tr()).evaluate().isNotEmpty,
    //   timeout: const Duration(seconds: 10),
    // ).then((_){
    //   print('✅ Home screen navigated');
    // });
    print('✅ Verify button tapped');

    expect(find.textContaining(AppStrings.bestSeller.tr()), findsOneWidget);
    print('🎉 SUCCESS: Home screen appeared!');
  });
}

/// امتداد لانتظار عنصر يظهر
extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await pump(const Duration(milliseconds: 100));
      if (any(finder)) return;
    }
    throw Exception('❌ Widget not found: $finder');
  }
}

extension WidgetTesterWaitExtension on WidgetTester {
  Future<void> pumpUntil(
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await pump(const Duration(milliseconds: 100));
      if (condition()) return;
    }
    throw Exception('⏰ pumpUntil timeout exceeded while waiting for condition');
  }
}
