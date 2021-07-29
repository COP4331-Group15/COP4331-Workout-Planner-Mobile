import 'dart:ui';

import 'package:flutter/material.dart';

import 'textauth.dart';
import 'calender.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

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
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/dumbell.png',
                      width: 70,
                      height: 40,
                    ),
                  ),
                  Text(
                    'Notebook',
                    style: TextStyle(
                        fontFamily: 'ChunkFive',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ],
              )),
        ),
        body: Column(children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width / 2.5,
                      alignment: Alignment.center,
                      child: Text(
                        'Keep up your hard work!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'ChunkFive',
                            fontSize: 20,
                            color: Colors.black),
                      )),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Image.asset('assets/running.png',
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5),
                  ),
                ],
              )),
          ListView(padding: const EdgeInsets.all(2), children: [
            Container(child: TextAuth(passedText: 'Username')),
            Container(child: TextAuth(passedText: 'Password')),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                margin: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width / 2.5,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.green[900],
                      elevation: 2,
                    ),
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                          fontFamily: 'Georgia',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ))),
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width / 2.5,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalenderPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.green[900],
                    elevation: 2,
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  )),
            )
          ]),
        ]));
  }
}
