import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sajilotantra/features/home/presentation/view_model/home_cubit.dart';
import 'package:sajilotantra/features/home/presentation/view_model/home_state.dart';
import 'package:sajilotantra/features/userprofile/presentation/view_model/user_bloc.dart';
import 'package:sajilotantra/features/userprofile/presentation/view_model/user_state.dart';

import '../../../userprofile/presentation/view/profile_modal.dart';
import '../../../userprofile/presentation/view_model/user_event.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(
            create: (_) => GetIt.instance<UserBloc>()..add(FetchUserProfile())),
      ],
      child: const SocialMediaUI(),
    );
  }
}

class SocialMediaUI extends StatelessWidget {
  const SocialMediaUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 241, 248, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              height: 30,
              width: 30,
              key: const Key('app_logo'), // ✅ Add key for testing
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                key: const Key('search_bar'), // ✅ Add key for testing
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color.fromRGBO(234, 241, 248, 1),
                  contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            key: const Key('notification_icon'), // ✅ Add key for testing
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          GestureDetector(
            key: const Key('profile_avatar'), // ✅ Add key for testing
            onTap: () => showProfileModal(context),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: state.user.profileImage != null &&
                            state.user.profileImage!.isNotEmpty
                        ? NetworkImage(state.user.profileImage!.trim())
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                  );
                } else {
                  return const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views[state.selectedIndex];
        },
      ),
      bottomNavigationBar: Container(
        key: const Key('bottom_nav_bar'), // ✅ Add key for testing
        margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                    context, Icons.home, 0, state.selectedIndex, 'nav_home'),
                _buildNavItem(context, Icons.calendar_month, 1,
                    state.selectedIndex, 'nav_calendar'),
                _buildNavItem(
                    context, Icons.map, 2, state.selectedIndex, 'nav_map'),
                _buildNavItem(context, Icons.document_scanner, 3,
                    state.selectedIndex, 'nav_documents'),
                _buildNavItem(context, Icons.settings, 4, state.selectedIndex,
                    'nav_settings'),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index,
      int currentIndex, String key) {
    return GestureDetector(
      key: Key(key), // ✅ Assign keys dynamically for each navigation item
      onTap: () => context.read<HomeCubit>().selectTab(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: currentIndex == index
              ? const Color.fromRGBO(243, 40, 84, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: currentIndex == index ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
