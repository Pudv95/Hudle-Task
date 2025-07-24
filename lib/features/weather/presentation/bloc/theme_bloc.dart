import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}

// States
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeMode themeMode;

  const ThemeLoaded(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;

  ThemeBloc({required this.sharedPreferences}) : super(ThemeInitial()) {
    on<ToggleTheme>(_onToggleTheme);
    on<LoadTheme>(_onLoadTheme);
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final currentTheme = state is ThemeLoaded
        ? (state as ThemeLoaded).themeMode
        : ThemeMode.system;

    ThemeMode newTheme;
    switch (currentTheme) {
      case ThemeMode.light:
        newTheme = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newTheme = ThemeMode.system;
        break;
      case ThemeMode.system:
        newTheme = ThemeMode.light;
        break;
    }

    await sharedPreferences.setString(AppConstants.themeModeKey, newTheme.name);
    emit(ThemeLoaded(newTheme));
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final themeName = sharedPreferences.getString(AppConstants.themeModeKey);
    ThemeMode themeMode;

    switch (themeName) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }

    emit(ThemeLoaded(themeMode));
  }
}
