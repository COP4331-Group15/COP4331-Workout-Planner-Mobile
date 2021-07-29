import 'dart:ui';

import 'package:flutter/material.dart';

import 'homepage.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const appName = 'Hercules\' Notebook';

    return MaterialApp(
        title: appName,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey,
          accentColor: Colors.green,
        ),
        home: const HomePage(
          title: appName,
        ));
  }
}
