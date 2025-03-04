import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isDarkMode = false; // Local state for static toggle display

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Theme.of(context).cardColor,
              child: ListTile(
                title: Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  "Toggle between light and dark themes",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode =
                          value; // Only updates local UI, no app-wide effect
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
