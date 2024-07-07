import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallzy/views/screens/categories.dart';
import 'package:wallzy/views/screens/home.dart';
import 'package:wallzy/views/screens/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late HomeScreen home;
  late SearchScreen search;
  late CategoriesScreen categories;
  late Widget currentPage;

  @override
  void initState() {
    home = HomeScreen();
    search = SearchScreen();
    categories = CategoriesScreen();
    pages = [home, search, categories];
    currentPage = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          color: const Color.fromARGB(255, 84, 87, 93),
          backgroundColor: Colors.white,
          buttonBackgroundColor: const Color.fromARGB(255, 84, 87, 93),
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.category_outlined,
              color: Colors.white,
            ),
          ]),
    );
  }
}
