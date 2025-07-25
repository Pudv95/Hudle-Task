import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hudle_task/features/weather/presentation/bloc/theme_bloc.dart';
import 'package:hudle_task/core/constants/app_constants.dart';

// Generate mocks
@GenerateMocks([SharedPreferences])
import 'theme_bloc_test.mocks.dart';

void main() {
  group('ThemeBloc', () {
    late MockSharedPreferences mockSharedPreferences;
    late ThemeBloc themeBloc;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      themeBloc = ThemeBloc(sharedPreferences: mockSharedPreferences);
    });

    tearDown(() {
      themeBloc.close();
    });

    test('initial state should be ThemeInitial', () {
      expect(themeBloc.state, isA<ThemeInitial>());
    });

    group('LoadTheme', () {
      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] when LoadTheme is added and no theme is saved',
        build: () {
          when(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).thenReturn(null);
          return themeBloc;
        },
        act: (bloc) => bloc.add(const LoadTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with light theme when LoadTheme is added and light theme is saved',
        build: () {
          when(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).thenReturn('light');
          return themeBloc;
        },
        act: (bloc) => bloc.add(const LoadTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with dark theme when LoadTheme is added and dark theme is saved',
        build: () {
          when(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).thenReturn('dark');
          return themeBloc;
        },
        act: (bloc) => bloc.add(const LoadTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with system theme when LoadTheme is added and system theme is saved',
        build: () {
          when(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).thenReturn('system');
          return themeBloc;
        },
        act: (bloc) => bloc.add(const LoadTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.getString(AppConstants.themeModeKey),
          ).called(1);
        },
      );
    });

    group('ToggleTheme', () {
      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with light theme when ToggleTheme is added from initial state',
        build: () {
          when(
            mockSharedPreferences.setString(AppConstants.themeModeKey, 'light'),
          ).thenAnswer((_) async => true);
          return themeBloc;
        },
        act: (bloc) => bloc.add(const ToggleTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.setString(AppConstants.themeModeKey, 'light'),
          ).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with dark theme when ToggleTheme is added from light theme',
        build: () {
          when(
            mockSharedPreferences.setString(AppConstants.themeModeKey, 'dark'),
          ).thenAnswer((_) async => true);
          return themeBloc;
        },
        seed: () => const ThemeLoaded(ThemeMode.light),
        act: (bloc) => bloc.add(const ToggleTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.setString(AppConstants.themeModeKey, 'dark'),
          ).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with system theme when ToggleTheme is added from dark theme',
        build: () {
          when(
            mockSharedPreferences.setString(
              AppConstants.themeModeKey,
              'system',
            ),
          ).thenAnswer((_) async => true);
          return themeBloc;
        },
        seed: () => const ThemeLoaded(ThemeMode.dark),
        act: (bloc) => bloc.add(const ToggleTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.setString(
              AppConstants.themeModeKey,
              'system',
            ),
          ).called(1);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits [ThemeLoaded] with light theme when ToggleTheme is added from system theme',
        build: () {
          when(
            mockSharedPreferences.setString(AppConstants.themeModeKey, 'light'),
          ).thenAnswer((_) async => true);
          return themeBloc;
        },
        seed: () => const ThemeLoaded(ThemeMode.system),
        act: (bloc) => bloc.add(const ToggleTheme()),
        expect: () => [isA<ThemeLoaded>()],
        verify: (_) {
          verify(
            mockSharedPreferences.setString(AppConstants.themeModeKey, 'light'),
          ).called(1);
        },
      );
    });

    group('Theme State Properties', () {
      test('ThemeLoaded state should have correct themeMode property', () {
        const themeState = ThemeLoaded(ThemeMode.dark);
        expect(themeState.themeMode, equals(ThemeMode.dark));
      });

      test(
        'ThemeLoaded states with different themeModes should not be equal',
        () {
          const lightTheme = ThemeLoaded(ThemeMode.light);
          const darkTheme = ThemeLoaded(ThemeMode.dark);
          expect(lightTheme, isNot(equals(darkTheme)));
        },
      );

      test('ThemeLoaded states with same themeMode should be equal', () {
        const theme1 = ThemeLoaded(ThemeMode.system);
        const theme2 = ThemeLoaded(ThemeMode.system);
        expect(theme1, equals(theme2));
      });
    });
  });
}
