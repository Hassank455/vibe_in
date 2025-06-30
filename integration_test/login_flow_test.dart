import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/ui/verification_screen.dart';
import 'package:vibe_in/main.dart' as app;
import 'package:vibe_in/core/routing/routes.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login -> OTP -> HomeScreen', (WidgetTester tester) async {
    // 🟢 1. Start app on login screen
    app.main(initialRouteOverride: Routes.loginScreen);
    await tester.pumpAndSettle();
    print('✅ App launched');

    // 🟢 2. Enter phone number
    final phoneField = find.byKey(const Key('phone_field'));
    await tester.pumpUntilFound(phoneField);
    await tester.enterText(phoneField, '512345678');
    await tester.pumpAndSettle();
    print('📱 Phone number entered');

    // 🟢 3. Tap on continue/login button
    final loginButton = find.byKey(const Key('login_button_click'));
    await tester.tap(loginButton);
    await tester.pumpUntil(
      () => find.byKey(const Key('otp_field')).evaluate().isNotEmpty,
      timeout: const Duration(seconds: 10),
    );
    print('🔁 Waiting for VerificationScreen...');

    // 🟢 4. Expect to navigate to verification screen
    final otpField = find.byKey(const Key('otp_field'));
    await tester.pumpUntilFound(otpField);
    expect(otpField, findsOneWidget);
    print('🔑 Verification screen appeared');

    // 🟢 5. Enter OTP (code is prefilled in the controller in real app, so we simulate valid input)
    final context = tester.element(find.byType(VerificationScreen));
    final verificationCubit = context.read<VerificationCubit>();
    final otp = verificationCubit.code;
    await tester.enterText(otpField, otp);

    await tester.pump();
    print('✍️ OTP entered');

    final homeIndicator = find.text(AppStrings.bestSeller.tr());
    await tester.pumpUntilFound(homeIndicator);
    expect(homeIndicator, findsOneWidget);
    print('🎉 SUCCESS: Home screen appeared!');
  });
}

extension PumpUntilFoundExtension on WidgetTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final endTime = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(endTime)) {
      await pump(const Duration(milliseconds: 200));
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
