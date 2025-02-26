import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_profile_view.dart';

void showProfileModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildModalItem(Icons.person, "Profile", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserProfileScreen()),
            );
          }),
          _buildModalItem(Icons.feedback, "Feedback", () {
            // Navigate to feedback page
          }),
          _buildModalItem(Icons.dark_mode, "Dark Mode", () {
            // Handle dark mode toggle
          }),
          _buildModalItem(Icons.logout, "Logout", () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('token'); // ✅ Remove token from storage
            Navigator.pop(context);
            // Navigate to login screen
          }),
        ],
      );
    },
  );
}

Widget _buildModalItem(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: onTap,
  );
}
