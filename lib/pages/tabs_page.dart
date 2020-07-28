import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../pages/favorites_page.dart';
import '../pages/categories_page.dart';
import '../models/meal.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsPage(this.favoriteMeals);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _pages = [
      {'page': CategoriesPage(), 'title': 'Categories', 'icon': Icons.category},
      {
        'page': FavoritesPage(widget.favoriteMeals),
        'title': 'Favorites',
        'icon': Icons.star
      }
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   // initialIndex: 1,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meals'),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           )
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: <Widget>[CategoriesPage(), FavoritesPage()],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: _pages.map((tab) {
          return BottomNavigationBarItem(
              // backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(tab['icon']),
              title: Text(tab['title']));
        }).toList(),
      ),
    );
  }
}
