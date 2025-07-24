import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        IconData icon;
        if (state is ThemeLoaded) {
          switch (state.themeMode) {
            case ThemeMode.light:
              icon = Icons.light_mode;
              break;
            case ThemeMode.dark:
              icon = Icons.dark_mode;
              break;
            case ThemeMode.system:
              icon = Icons.brightness_auto;
              break;
          }
        } else {
          icon = Icons.brightness_auto;
        }

        return IconButton(
          onPressed: () {
            context.read<ThemeBloc>().add(const ToggleTheme());
          },
          icon: Icon(icon),
          tooltip: 'Toggle theme',
        );
      },
    );
  }
}
