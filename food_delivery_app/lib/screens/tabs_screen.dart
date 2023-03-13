import 'package:flutter/material.dart';

import './favorites_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List favorites;
  const TabsScreen(this.favorites,{super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
   late List _pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) => setState(() {
        _selectedPageIndex = index;
      });


  @override
  void initState() {
    _pages = [
    {'page': const CategoriesScreen(), 'title': 'foodpanda'},
    {'page':  FavoritesScreen(widget.favorites), 'title': 'favorites'}
  ];

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    return Scaffold(
      appBar: AppBar(
  title: Text(_pages[_selectedPageIndex]['title']),
  actions: _selectedPageIndex == 0
      ? [
          IconButton(
            icon: const Icon(
              Icons.favorite_outline_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              _selectPage(1);
            },
          ),
        ]
      : [],
),
drawer: const MainDrawer(),


      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.125,
        child: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const SizedBox(height: 20, child: Icon(Icons.home)),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const SizedBox(
                    height: 20, child: Icon(Icons.favorite_outline)),
                label: 'Favorites',
              )
            ]),
      ),
    );
  }
}
