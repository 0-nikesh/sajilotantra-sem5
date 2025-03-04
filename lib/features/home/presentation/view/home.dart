import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sajilotantra/features/home/presentation/view_model/home_cubit.dart';
import 'package:sajilotantra/features/home/presentation/view_model/home_state.dart';
import 'package:sajilotantra/features/userprofile/presentation/view_model/user_bloc.dart';
import 'package:sajilotantra/features/userprofile/presentation/view_model/user_state.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/presentation/view/login.dart';
import '../../../userprofile/presentation/view/profile_modal.dart';
import '../../../userprofile/presentation/view_model/user_event.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Timer? _brightnessTimer;
  StreamSubscription? _accelerometerSubscription;
  final double _shakeThreshold = 15.0;
  int _shakeCount = 0;
  final int _shakeCountThreshold = 3;
  double _previousX = 0, _previousY = 0, _previousZ = 0;

  @override
  void initState() {
    super.initState();
    _startBrightnessListener(); // Start brightness detection
    _startShakeDetection(); // Start shake detection
  }

  /// Continuously listen for brightness changes every 3 seconds (for logging only)
  void _startBrightnessListener() {
    _brightnessTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkBrightness();
    });
  }

  /// Check screen brightness in real-time (for debugging, no UI impact)
  Future<void> _checkBrightness() async {
    try {
      double brightness = await ScreenBrightness().current;
      print("📊 Real-time Brightness: $brightness");
      // Note: No setState here; theme is handled by ThemeMode.system in app.dart
    } catch (e) {
      print("❌ Error getting brightness: $e");
    }
  }

  /// Detect Shake to Logout
  void _startShakeDetection() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      double deltaX = (_previousX - event.x).abs();
      double deltaY = (_previousY - event.y).abs();
      double deltaZ = (_previousZ - event.z).abs();

      _previousX = event.x;
      _previousY = event.y;
      _previousZ = event.z;

      if ((deltaX > _shakeThreshold ||
          deltaY > _shakeThreshold ||
          deltaZ > _shakeThreshold)) {
        _shakeCount++;
        print("Shake Count: $_shakeCount");

        if (_shakeCount >= _shakeCountThreshold) {
          print("🚀 Shake detected! Logging out...");
          _logoutUser();
          _shakeCount = 0;
        }
      }
    });
  }

  /// Logout user
  Future<void> _logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print("✅ Token removed. Redirecting to login...");

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _brightnessTimer?.cancel(); // Stop brightness timer
    _accelerometerSubscription?.cancel(); // Stop accelerometer listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(
          create: (_) => GetIt.instance<UserBloc>()..add(FetchUserProfile()),
        ),
      ],
      child: const SocialMediaUI(), // No need to pass isDarkMode
    );
  }
}

class SocialMediaUI extends StatelessWidget {
  const SocialMediaUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                  prefixIcon: Icon(Icons.search,
                      color: Theme.of(context).iconTheme.color),
                  filled: true,
                  fillColor: Theme.of(context).cardColor.withOpacity(0.8),
                  contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => showProfileModal(context),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return CircleAvatar(
                    backgroundColor: Theme.of(context).cardColor,
                    backgroundImage: state.user.profileImage != null &&
                            state.user.profileImage!.isNotEmpty
                        ? NetworkImage(state.user.profileImage!.trim())
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                  );
                } else {
                  return CircleAvatar(
                    backgroundColor: Theme.of(context).cardColor,
                    backgroundImage:
                        const AssetImage('assets/images/avatar.png'),
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
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
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
              _buildNavItem(context, Icons.home, 0, state.selectedIndex),
              _buildNavItem(
                  context, Icons.calendar_month, 1, state.selectedIndex),
              _buildNavItem(context, Icons.map, 2, state.selectedIndex),
              _buildNavItem(
                  context, Icons.document_scanner, 3, state.selectedIndex),
              _buildNavItem(context, Icons.settings, 4, state.selectedIndex),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, int index, int currentIndex) {
    return GestureDetector(
      onTap: () => context.read<HomeCubit>().selectTab(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: currentIndex == index
              ? Colors.white
              : Theme.of(context).iconTheme.color?.withOpacity(0.7),
        ),
      ),
    );
  }
}
