import 'package:flutter/material.dart';
import 'package:navigation/dummy_data.dart';
import 'package:navigation/screens/categories_screens.dart';
import 'package:navigation/screens/filters_screen.dart';
import './models/Meal.dart';
import './dummy_data.dart';
import 'screens/category_meals_screens.dart';
import './screens/meal_detail_screen.dart';
import './screens/tab_screen.dart';

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
    'vegetrian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'daily mealss',
      theme: ThemeData(
        primarySwatch: Colors.lime,

        accentColor: Colors.yellow,
        canvasColor: Color.fromRGBO(255, 245, 89, 0.2),
        fontFamily: 'Raelway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 90, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 90, 1)),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        //       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: CategoriesScreen(),
      initialRoute: '/', // default is /
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
      //  onUnknownRoute: (settings) => {
      //  return MaterialPageRoute(builder: (ctx) => CategoriesScreen()
      //},
    );
  }
}
