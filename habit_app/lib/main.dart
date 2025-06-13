import 'package:flutter/material.dart';
import 'package:habit_app/database/habit_database.dart';
import 'package:habit_app/pages/home_page.dart';
import 'package:habit_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // initialize database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
