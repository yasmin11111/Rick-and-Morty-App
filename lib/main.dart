import 'package:flutter/material.dart';

import 'Core/Resources/RoutesManager.dart' show RoutesManager, RoutesNames;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      onGenerateRoute:RoutesManager.onGenerateRoutes,
      initialRoute: RoutesNames.CharactersScreen,

    );
  }
}

