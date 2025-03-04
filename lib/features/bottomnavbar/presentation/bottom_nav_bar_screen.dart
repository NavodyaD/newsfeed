// lib/features/bottom_nav_bar/presentation/bottom_nav_bar_screen.dart
import 'package:flutter/material.dart';
import 'package:newsfeed/features/homepage/presentation/homepage.dart';
import 'package:newsfeed/features/news/presentation/pages/news_page.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const NewsFeedPage(),
    const HomePage(),
    const HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: _selectedIndex == 0 ? 1.2 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              ),
            ),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: _selectedIndex == 1 ? 1.2 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(
                Icons.search,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
            ),
            label: 'Search',
            tooltip: 'Search',
          ),
          BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: _selectedIndex == 2 ? 1.2 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(
                Icons.person,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
            ),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
