import 'package:delivery_app/feature/home/presentation/pages/special_screen.dart';
import 'package:delivery_app/feature/home/presentation/pages/home_screen.dart';
import 'package:delivery_app/feature/home/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int? index;

  const HomePage({super.key, this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SpecialScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    setState(() {
      _currentIndex = widget.index ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Specials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
