// lib/features/bottom_nav_bar/presentation/bottom_nav_bar_screen.dart
import 'package:flutter/material.dart';
import 'package:newsfeed/features/homepage/presentation/homepage.dart';
import 'package:newsfeed/features/news/presentation/pages/news_page.dart';
import 'package:newsfeed/features/news/presentation/pages/search_page.dart';

import '../../news/data/datasource/news_api_service.dart';
import '../../news/data/repositories/news_repository_impl.dart';
import '../../news/domain/repositories/news_repository.dart';
import '../../news/domain/usecases/search_news_usecase.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

final NewsApiService apiService = NewsApiService();
final NewsRepository newsRepository = NewsRepositoryImpl(apiService);
final SearchNewsUseCase searchNewsUseCase = SearchNewsUseCase(newsRepository);

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const NewsFeedPage(),
    NewsSearchPage(searchNewsUseCase: searchNewsUseCase),
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
