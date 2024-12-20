import 'package:flutter/material.dart';
import 'package:sajilotantra/bottom_screen/calendar.dart';
import 'package:sajilotantra/bottom_screen/document.dart';
import 'package:sajilotantra/bottom_screen/home.dart';
import 'package:sajilotantra/bottom_screen/map.dart';
import 'package:sajilotantra/bottom_screen/setting.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SocialMediaUI(),
    );
  }
}

class SocialMediaUI extends StatefulWidget {
  const SocialMediaUI({super.key});

  @override
  _SocialMediaUIState createState() => _SocialMediaUIState();
}

class _SocialMediaUIState extends State<SocialMediaUI> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Calendar(),
    const MapScreen(),
    const Document(),
    const Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            ),
            const SizedBox(width: 20),
            Flexible(
              child: TextField(
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
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              const Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.calendar_month, 1),
            _buildNavItem(Icons.map, 2),
            _buildNavItem(Icons.document_scanner, 3),
            _buildNavItem(Icons.settings, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? const Color.fromRGBO(243, 40, 84, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
