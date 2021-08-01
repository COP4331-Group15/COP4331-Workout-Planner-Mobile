import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:large_project_app/widgets/appbar.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String errorMsg = "";
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      setState(() {
        errorMsg = e.message!;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: CustomAppBar()),
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
                        'Let\'s start your journey to fitness!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'ChunkFive',
                            fontSize: 20,
                            color: Colors.black),
                      )),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Image.asset('assets/bodybuilder.png',
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
                    _createUser();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.green[900],
                    elevation: 2,
                  ),
                  child: Text(
                    'Sign Up',
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
