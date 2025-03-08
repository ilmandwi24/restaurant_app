import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/daily_reminder_field.dart';
import 'package:restaurant_app/widgets/dark_mode_field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings Screen"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Theme",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                const DarkModeField(),
                const SizedBox(height: 12),
                Text(
                  "Daily Reminder ",
                  style: Theme.of(context).textTheme.titleLarge,

                ),
                const DailyReminderField()

              ],
            ),
          ),
      )
    );
  }
}
