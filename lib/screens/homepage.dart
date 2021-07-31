import 'dart:ui';

import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
          title: Container(
              margin: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hercules\'',
                    style: TextStyle(
                        fontFamily: 'ChunkFive',
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/dumbell.png',
                      width: 75,
                      height: 45,
                    ),
                  ),
                  Text(
                    'Notebook',
                    style: TextStyle(
                        fontFamily: 'ChunkFive',
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ],
              )),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 5)),
                        child: Column(children: [
                          Stack(children: [
                            Text(
                              'Plan your perfect workout today',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Theme.of(context).accentColor),
                            ),
                            Text('Plan your perfect workout today',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.black)),
                          ]),
                          Container(
                              margin: const EdgeInsets.all(15.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 120,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignupPage()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            onPrimary: Colors.green[900],
                                            elevation: 10,
                                          ),
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                fontFamily: 'Georgia',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.black),
                                          )),
                                    ),
                                    SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              onPrimary: Colors.green[900],
                                              elevation: 10,
                                            ),
                                            child: Text(
                                              'Log In',
                                              style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            )))
                                  ]))
                        ]))
                  ]),
            )));
  }
}
