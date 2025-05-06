import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/cubit/login_state.dart';
import 'package:vibe_in/features/auth/login/ui/login_screen.dart';

// Defining a mock (وهمي) class for LoginCubit so that we can control its behavior in the test
class MockLoginCubit extends Mock implements LoginCubit {}

void main() {
  late MockLoginCubit mockLoginCubit;

  // Executed before every test
  setUp(() {
    mockLoginCubit = MockLoginCubit();
    // ✅ توفير stream وهمي
    when(
      () => mockLoginCubit.stream,
    ).thenAnswer((_) => const Stream<LoginState>.empty());

    // ✅ توفير state أولي وهمي
    when(() => mockLoginCubit.state).thenReturn(LoginInitial());
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'), // Default language
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // نفس التصميم الأصلي
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            locale: const Locale('en'),
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            builder:
                (context, widget) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                ),
            home: BlocProvider<LoginCubit>.value(
              value: mockLoginCubit,
              child: const LoginScreen(),
            ),
          );
        },
      ),
    );
  }

  testWidgets('should display login UI elements', (WidgetTester tester) async {
    // • The LoginScreen uses loginCubit.formKey and loginCubit.phoneController.
    // • Here we're telling the mock: "If someone calls you to get the formKey or controller, return this to them."
    when(() => mockLoginCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(
      () => mockLoginCubit.phoneController,
    ).thenReturn(TextEditingController());

    // Install the interface we want to test on the screen now.
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(); // ننتظر استقرار الواجهة
    // Check for texts
    expect(find.text(AppStrings.welcomeBack.tr()), findsOneWidget);
    expect(find.text(AppStrings.enterYourMobileNumber.tr()), findsOneWidget);

    // Verify the presence of the mobile field
    expect(find.byKey(const Key('phone_field')), findsOneWidget);

    // Check the continue button
    expect(find.byKey(const Key('login_button_click')), findsOneWidget);
  });

  //! Good
  testWidgets('should show validation error when phone is empty', (
    WidgetTester tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();

    when(() => mockLoginCubit.formKey).thenReturn(formKey);
    when(() => mockLoginCubit.phoneController).thenReturn(phoneController);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('login_button_click')));
    // pump: Wait for the interface to be rebuilt after the action (e.g., an error message appears)
    await tester.pump(); // To display the error message after verification

    expect(
      find.text(AppStrings.pleaseEnterYourMobileNumber.tr()),
      findsOneWidget,
    );
  });

  testWidgets(
    'should show validation error when phone number is less than 9 digits',
    (WidgetTester tester) async {
      // مفاتيح النموذج (formKey) وحقل الهاتف
      final formKey = GlobalKey<FormState>();
      final phoneController = TextEditingController(
        text: '123',
      ); // رقم غير صحيح

      // عند استدعاء formKey أو controller، نرجّع القيم اللي فوق
      when(() => mockLoginCubit.formKey).thenReturn(formKey);
      when(() => mockLoginCubit.phoneController).thenReturn(phoneController);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // ننتظر حتى يتم تحميل الشاشة بالكامل

      await tester.tap(find.byKey(const Key('login_button_click')));
      await tester.pump(); // إعادة بناء الواجهة لعرض رسالة الخطأ

      expect(
        find.text(AppStrings.mobileNumberMustBe9Digits.tr()),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'should show validation error when phone number does not start with 5',
    (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      final phoneController = TextEditingController(text: '123456789');

      when(() => mockLoginCubit.formKey).thenReturn(formKey);
      when(() => mockLoginCubit.phoneController).thenReturn(phoneController);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // ننتظر حتى يتم تحميل الشاشة بالكامل

      await tester.tap(find.byKey(const Key('login_button_click')));
      await tester.pump();

      // Check if the expected error message appears.
      expect(
        find.text(AppStrings.mobileNumberMustStartWith5.tr()),
        findsOneWidget,
      );
    },
  );
}
