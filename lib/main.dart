import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:large_project_app/screens/calender.dart';

import 'screens/homepage.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey,
          accentColor: Colors.green,
        ),
        home: LandingPage());
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    Object? user = snapshot.data;

                    if (user == null) {
                      return HomePage();
                    } else {
                      return CalenderPage();
                    }
                  } else if (snapshot.hasError) {
                    final error = "snapshot.error";
                    return Text(error.toString());
                  }

                  return Scaffold(
                    body: Center(child: Text('Checking Authentification...')),
                  );
                });
          }

          return Scaffold(body: Center(child: Text('Connecting...')));
        });
  }
}
