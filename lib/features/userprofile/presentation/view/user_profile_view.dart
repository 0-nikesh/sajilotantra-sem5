import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../view_model/user_bloc.dart';
import '../view_model/user_event.dart';
import '../view_model/user_state.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<UserBloc>()..add(FetchUserProfile()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA), // Light background
        appBar: AppBar(
          title: const Text(
            "User Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            key: const Key('back_button'), // ✅ Key for back button
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                    key: Key('loading_indicator')), // ✅ Key for loading
              );
            } else if (state is UserLoaded) {
              final user = state.user;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image with Shadow
                    Container(
                      key: const Key(
                          'profile_image_container'), // ✅ Key for container
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        key: const Key('profile_image'), // ✅ Key for image
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: user.profileImage != null &&
                                user.profileImage!.isNotEmpty
                            ? NetworkImage(user.profileImage!)
                            : const AssetImage('assets/images/avatar.png')
                                as ImageProvider,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Full Name
                    Text(
                      "${user.fname} ${user.lname}",
                      key: const Key('user_fullname'), // ✅ Key for name
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),

                    // Email
                    Text(
                      user.email,
                      key: const Key('user_email'), // ✅ Key for email
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),

                    // Edit Profile Button
                    SizedBox(
                      width: 180,
                      child: ElevatedButton.icon(
                        key: const Key(
                            'edit_profile_button'), // ✅ Key for edit button
                        onPressed: () {
                          // Navigate to Edit Profile Page
                        },
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 132, 132, 132), // Modern theme
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  key: const Key('error_message'), // ✅ Key for error message
                ),
              );
            }
            return const Center(
              child: Text("No data available",
                  key: Key('no_data_message')), // ✅ Key for empty state
            );
          },
        ),
      ),
    );
  }
}
