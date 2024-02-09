import 'package:flutter/material.dart';
import 'package:handson/model/todo.dart';
import 'package:handson/pages/add_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/home_screen.dart';

final routeObserver = RouteObserver<ModalRoute>();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/add':
            final index = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (_) => AddScreen(
                index: index,
              ),
              settings: settings,
            );
          default:
            return MaterialPageRoute(builder: (_) => const Placeholder());
        }
      },
    );
  }
}
