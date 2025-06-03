import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinput/pinput.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_state.dart';
import 'package:vibe_in/features/auth/verification/ui/verification_screen.dart';

class MockVerificationCubit extends Mock implements VerificationCubit {}

void main() {
  late MockVerificationCubit mockVerificationCubit;

  setUp(() {
    mockVerificationCubit = MockVerificationCubit();

    when(
      () => mockVerificationCubit.stream,
    ).thenAnswer((_) => const Stream<VerificationState>.empty());
    when(() => mockVerificationCubit.state).thenReturn(VerificationState());
    when(() => mockVerificationCubit.mobile).thenReturn('512345678');
    when(() => mockVerificationCubit.code).thenReturn('1234');
    when(
      () => mockVerificationCubit.pinController,
    ).thenReturn(TextEditingController());
    when(() => mockVerificationCubit.pinPutFocusNode).thenReturn(FocusNode());
    when(() => mockVerificationCubit.formatTime()).thenReturn('01:30');
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // نفس التصميم الأصلي
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            locale: const Locale('en'),
            builder:
                (context, widget) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                ),
            home: BlocProvider<VerificationCubit>.value(
              value: mockVerificationCubit,
              child: const VerificationScreen(),
            ),
          );
        },
      ),
    );
  }

  testWidgets('should display OTP verification UI elements', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.verificationCode.tr()), findsOneWidget);
    expect(
      find.text(AppStrings.weSentATemporaryLoginCode.tr()),
      findsOneWidget,
    );
    expect(find.text('+966 512345678'), findsOneWidget);
    expect(find.byType(Pinput), findsOneWidget); // Pinput
    // expect(find.byKey(const Key('otp_field')), findsOneWidget);
    expect(find.text(AppStrings.verify.tr()), findsOneWidget);
    expect(find.text(AppStrings.didNotReceiveCode.tr()), findsOneWidget);
    expect(find.text(AppStrings.resendCode.tr()), findsOneWidget);
    expect(find.text('01:30'), findsOneWidget); // Timer text
  });

  testWidgets(
    'should show timeout SnackBar when timer is 0 and verify button is tapped',
    (WidgetTester tester) async {
      // Arrange
      when(
        () => mockVerificationCubit.state,
      ).thenReturn(VerificationState(start: 0));
      when(
        () => mockVerificationCubit.stream,
      ).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.tap(find.byKey(const Key('verify_button')));
      await tester.pump(); // SnackBar will show after pump

      // Assert
      expect(find.text(AppStrings.timeOut.tr()), findsOneWidget);
    },
  );
  testWidgets(
    'should call otpVerification when timer is not 0 and verify button is tapped',
    (WidgetTester tester) async {
      when(
        () => mockVerificationCubit.state,
      ).thenReturn(VerificationState(start: 10));
      when(
        () => mockVerificationCubit.stream,
      ).thenAnswer((_) => const Stream.empty());
      when(() => mockVerificationCubit.otpVerification()).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byKey(const Key('verify_button')));
      await tester.pump();

      verify(() => mockVerificationCubit.otpVerification()).called(1);
    },
  );
  testWidgets(
    'should show loading indicator when verificationStatus is loading',
    (WidgetTester tester) async {
      when(() => mockVerificationCubit.state).thenReturn(
        VerificationState(
          start: 10,
          verificationStatus: RequestsStatus.loading,
        ),
      );
      when(
        () => mockVerificationCubit.stream,
      ).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      final loadingIndicator = find.byWidgetPredicate(
        (widget) => widget.runtimeType.toString().contains('ThreeArchedCircle'),
      );
      expect(loadingIndicator, findsOneWidget);
    },
  );

  testWidgets('should call resendCode when Resend Code text is tapped', (
    WidgetTester tester,
  ) async {
    when(
      () => mockVerificationCubit.state,
    ).thenReturn(VerificationState(start: 10));
    when(
      () => mockVerificationCubit.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockVerificationCubit.resendCode()).thenReturn(null);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text(AppStrings.resendCode.tr()));
    await tester.pump();

    verify(() => mockVerificationCubit.resendCode()).called(1);
  });
}
