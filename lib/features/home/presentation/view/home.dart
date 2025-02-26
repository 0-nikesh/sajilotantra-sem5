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
  bool _isDarkMode = false;
  Timer? _brightnessTimer;
  StreamSubscription? _accelerometerSubscription;
  final double _shakeThreshold = 15.0;
  int _shakeCount = 0;
  final int _shakeCountThreshold = 3;
  double _previousX = 0, _previousY = 0, _previousZ = 0;

  @override
  void initState() {
    super.initState();
    _startBrightnessListener(); // ✅ Start brightness detection
    _startShakeDetection(); // ✅ Start shake detection
  }

  /// ✅ Continuously listen for brightness changes every 3 seconds
  void _startBrightnessListener() {
    _brightnessTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkBrightness();
    });
  }

  /// ✅ Check screen brightness in real-time
  Future<void> _checkBrightness() async {
    try {
      double brightness = await ScreenBrightness().current;
      print("📊 Real-time Brightness: $brightness");

      if (mounted) {
        setState(() {
          _isDarkMode =
              brightness < 0.3; // Toggle dark mode if brightness < 30%
        });
      }
    } catch (e) {
      print("❌ Error getting brightness: $e");
    }
  }

  /// ✅ Detect Shake to Logout
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

  /// ✅ Logout user
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
            create: (_) => GetIt.instance<UserBloc>()..add(FetchUserProfile())),
      ],
      child: SocialMediaUI(isDarkMode: _isDarkMode), // Pass dark mode state
    );
  }
}

class SocialMediaUI extends StatelessWidget {
  final bool isDarkMode; // 🔥 Accept dark mode status

  const SocialMediaUI({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode
          ? Colors.black // 🌑 Dark mode
          : const Color.fromRGBO(234, 241, 248, 1), // ☀️ Light mode
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            isDarkMode ? Colors.black : Colors.white, // Dark mode AppBar
        elevation: 0,
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
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: isDarkMode
                      ? Colors.grey[900]
                      : const Color.fromRGBO(234, 241, 248, 1),
                  contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => showProfileModal(context),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return CircleAvatar(
                    backgroundColor:
                        isDarkMode ? Colors.grey[800] : Colors.white,
                    backgroundImage: state.user.profileImage != null &&
                            state.user.profileImage!.isNotEmpty
                        ? NetworkImage(state.user.profileImage!.trim())
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                  );
                } else {
                  return CircleAvatar(
                    backgroundColor:
                        isDarkMode ? Colors.grey[800] : Colors.white,
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
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
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
              ? (isDarkMode
                  ? Colors.redAccent
                  : const Color.fromRGBO(243, 40, 84, 1))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: currentIndex == index
              ? Colors.white
              : (isDarkMode ? Colors.grey[400] : Colors.grey),
        ),
      ),
    );
  }
}
