
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/reminder_provider.dart';

class DailyReminderField extends StatefulWidget {
  const DailyReminderField({super.key});

  @override
  State<DailyReminderField> createState() => _DailyReminderFieldState();
}

class _DailyReminderFieldState extends State<DailyReminderField> {

  @override
  Widget build(BuildContext context) {
    // return Consumer<ReminderProvider>(
    //     builder: (context, reminderProvider, child) {
    //   return SwitchListTile.adaptive(
    //       title: const Text("Reminder 11 AM"),
    //       value: context.watch<ReminderProvider>().isReminderOn,
    //       onChanged: (value) async => reminderProvider.toggleReminder(value));
    // });
     return SwitchListTile.adaptive(
          title: const Text("Reminder 11 AM"),
          value: context.watch<ReminderProvider>().isReminderOn,
          onChanged: (value) async => context.read<ReminderProvider>().toggleReminder(),
          );
    
  }
}
