import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  String errorMsg = "";

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      errorMsg = e.message!;
    }
  }

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
          Expanded(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(2),
                  children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text(errorMsg,
                      style: TextStyle(
                        color: Colors.red,
                      )),
                ),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 50,
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5.0),
                        ),
                        hintText: "Email",
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 50,
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5.0),
                        ),
                        hintText: "Password",
                      ),
                    )),
              ])),
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
                    setState(() {
                      _createUser();
                    });
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
