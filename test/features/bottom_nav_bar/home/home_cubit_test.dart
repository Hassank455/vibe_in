import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HomeCubit homeCubit;

  setUp(() {
    homeCubit = HomeCubit();
  });

  tearDown(() async {
    await homeCubit.close();
  });

  test('initial state should be HomeInitial and indexScreen = 0', () {
    expect(homeCubit.state, isA<HomeInitial>());
    expect(homeCubit.indexScreen, 0);
  });

  blocTest<HomeCubit, HomeState>(
    'emits ChangeIndexScreen when setIndexScreen is called',
    build: () => HomeCubit(),
    act: (cubit) => cubit.setIndexScreen(3),
    expect: () => [isA<ChangeIndexScreen>()],
    verify: (cubit) {
      expect(cubit.indexScreen, 3);
    },
  );
}