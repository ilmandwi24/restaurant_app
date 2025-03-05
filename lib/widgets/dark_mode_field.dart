import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';

class DarkModeField extends StatefulWidget {
  const DarkModeField({super.key});

  @override
  State<DarkModeField> createState() => _DarkModeFieldState();
}

class _DarkModeFieldState extends State<DarkModeField> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: const Text("Dark Theme"),
      value: context.watch<ThemeProvider>().isDarkMode,
      onChanged: (value) => context.read<ThemeProvider>().toggleTheme(),

    );
    
  }
}
