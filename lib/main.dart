import 'package:flutter/material.dart';

import './data/dummy_data.dart';
import './pages/filters_page.dart';
import './pages/meal_detail_page.dart';
import './pages/tabs_page.dart';
import './pages/category_meals_page.dart';
import './pages/categories_page.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      home: TabsPage(_favoriteMeals),
      routes: {
        CategoryMealsPage.routeName: (ctx) =>
            CategoryMealsPage(_availableMeals),
        MealDetailPage.routeName: (ctx) =>
            MealDetailPage(_toggleFavorite, _isMealFavorite),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters, _setFilters)
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesPage());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesPage());
      },
    );
  }
}
