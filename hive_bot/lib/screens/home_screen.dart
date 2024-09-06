import 'package:flutter/material.dart';
import 'package:hive_bot/screens/chat_history_screen.dart';
import 'package:hive_bot/screens/chat_screen.dart';
import 'package:hive_bot/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _screens = const [
    ChatScreen(),
    ProfileScreen(),
    ChatHistoryScreen(),
  ];
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 0,
        selectedItemColor:  Theme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceIn);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
