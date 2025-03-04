// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';

// import '../view_model/user_bloc.dart';
// import '../view_model/user_event.dart';
// import '../view_model/user_state.dart';

// class UserProfileScreen extends StatelessWidget {
//   const UserProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => GetIt.instance<UserBloc>()..add(FetchUserProfile()),
//       child: Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text(
//             "User Profile",
//             style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//           foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
//           elevation: Theme.of(context).appBarTheme.elevation,
//           centerTitle: true,
//         ),
//         body: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                     key: Key('loading_indicator')), // Key for loading
//               );
//             } else if (state is UserLoaded) {
//               final user = state.user;
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Cover Image
//                     Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           user.cover ??
//                               'https://via.placeholder.com/300x100', // Fallback
//                           width: double.infinity,
//                           height: 150,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: double.infinity,
//                               height: 150,
//                               color: Colors.grey.withOpacity(0.3),
//                               child: const Center(
//                                 child: Icon(Icons.error, color: Colors.red),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Profile Image with Shadow
//                     Container(
//                       key: const Key('profile_image_container'),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             spreadRadius: 5,
//                           ),
//                         ],
//                       ),
//                       child: CircleAvatar(
//                         key: const Key('profile_image'),
//                         radius: 65,
//                         backgroundColor: Theme.of(context).cardColor,
//                         backgroundImage:
//                             user.image != null && user.image!.isNotEmpty
//                                 ? NetworkImage(user.image!)
//                                 : const AssetImage('assets/images/avatar.png')
//                                     as ImageProvider,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Username (Full Name)
//                     Text(
//                       "${user.fname ?? ''} ${user.lname ?? ''}",
//                       key: const Key('user_fullname'),
//                       style:
//                           Theme.of(context).textTheme.headlineSmall?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 8),

//                     // Email
//                     Text(
//                       user.email ?? 'No email available',
//                       key: const Key('user_email'),
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                             color: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge
//                                 ?.color
//                                 ?.withOpacity(0.7),
//                           ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),

//                     // Bio
//                     if (user.bio != null && user.bio!.isNotEmpty)
//                       Card(
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         color: Theme.of(context).cardColor,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Text(
//                             user.bio!,
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     const SizedBox(height: 24),

//                     // Edit Profile Button
//                     SizedBox(
//                       width: 200,
//                       child: ElevatedButton.icon(
//                         key: const Key('edit_profile_button'),
//                         onPressed: () {
//                           // Navigate to Edit Profile Page (implement navigation)
//                         },
//                         icon: const Icon(Icons.edit, color: Colors.white),
//                         label: Text(
//                           "Edit Profile",
//                           style:
//                               Theme.of(context).textTheme.titleMedium?.copyWith(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Theme.of(context).primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           elevation: 2,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is UserError) {
//               return Center(
//                 child: Text(
//                   "Error: ${state.message}",
//                   key: const Key('error_message'),
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: Theme.of(context).colorScheme.error,
//                       ),
//                 ),
//               );
//             }
//             return Center(
//               child: Text(
//                 "No data available",
//                 key: const Key('no_data_message'),
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyLarge
//                           ?.color
//                           ?.withOpacity(0.7),
//                     ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "User Profile",
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          elevation: Theme.of(context).appBarTheme.elevation,
          actions: [
            IconButton(
              icon: Icon(Icons.settings,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                // Navigate to settings or edit profile (optional)
              },
            ),
          ],
          centerTitle: true,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(key: Key('loading_indicator')),
              );
            } else if (state is UserLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Cover and Profile Image (Facebook-style)
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Cover Image
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              user.cover ??
                                  'https://via.placeholder.com/300x150',
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey.withOpacity(0.3),
                                  child: const Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Profile Image
                        Positioned(
                          top: 100, // Position below cover image
                          child: Container(
                            key: const Key('profile_image_container'),
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
                              key: const Key('profile_image'),
                              radius: 60,
                              backgroundColor: Theme.of(context).cardColor,
                              backgroundImage: user.image != null &&
                                      user.image!.isNotEmpty
                                  ? NetworkImage(user.image!)
                                  : const AssetImage('assets/images/avatar.png')
                                      as ImageProvider,
                              // errorBuilder: (context, error, stackTrace) {
                              //   return const AssetImage('assets/images/avatar.png')
                              //       as ImageProvider;
                              // },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 80), // Space for profile image overlap

                    // User Info Section
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Username (Full Name)
                          Text(
                            "${user.fname ?? ''} ${user.lname ?? ''}",
                            key: const Key('user_fullname'),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),

                          // Email
                          Text(
                            user.email ?? 'No email available',
                            key: const Key('user_email'),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color
                                          ?.withOpacity(0.7),
                                    ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          // Bio
                          if (user.bio != null && user.bio!.isNotEmpty)
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Theme.of(context).cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  user.bio!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Navigation Tabs (Facebook-like: Posts, Friends, Photos, etc.)
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     _buildTabButton(context, 'Posts', Icons.post_add, () {
                    //       // Navigate to posts screen or update UI
                    //     }),
                    //     _buildTabButton(context, 'Friends', Icons.people, () {
                    //       // Navigate to friends screen or update UI
                    //     }),
                    //     _buildTabButton(context, 'Photos', Icons.photo, () {
                    //       // Navigate to photos screen or update UI
                    //     }),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),

                    // Edit Profile Button
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton.icon(
                          key: const Key('edit_profile_button'),
                          onPressed: () {
                            // Navigate to Edit Profile Page (implement navigation)
                          },
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: Text(
                            "Edit Profile",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 2,
                          ),
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
                  key: const Key('error_message'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              );
            }
            return Center(
              child: Text(
                "No data available",
                key: const Key('no_data_message'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.7),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabButton(
      BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
