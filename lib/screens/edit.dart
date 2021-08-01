import 'package:flutter/material.dart';
import 'package:large_project_app/widgets/appbar.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _startTime = new TextEditingController();
  bool isChecked = false;
  final TextEditingController _muscleGroup = new TextEditingController();
  final TextEditingController _exerciseName = new TextEditingController();
  final TextEditingController _sets = new TextEditingController();
  final TextEditingController _repititions = new TextEditingController();
  final TextEditingController _duration = new TextEditingController();
  final TextEditingController _resistance = new TextEditingController();

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
                        'Set your plans!',
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
                Center(
                    child: Container(
                  child: Text("Edit Workout",
                      style: TextStyle(
                        fontFamily: "ChunkFive",
                        fontSize: 20,
                      )),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2))),
                )),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 50,
                    child: TextField(
                      controller: _startTime,
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
                        hintText: "Start time",
                      ),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      margin: const EdgeInsets.all(15.0),
                      child: Text("Unworkable:")),
                  Container(
                      child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }))
                ]),
                Center(
                    child: Container(
                  child: Text("Edit Exercise",
                      style: TextStyle(
                        fontFamily: "ChunkFive",
                        fontSize: 20,
                      )),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2))),
                )),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 50,
                    child: TextField(
                      controller: _muscleGroup,
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
                        hintText: "Muscle group",
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 50,
                    child: TextField(
                      controller: _exerciseName,
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
                        hintText: "Exercise name",
                      ),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 50,
                          width: 75,
                          child: TextField(
                            controller: _sets,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 5.0),
                              ),
                              hintText: "Sets",
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 50,
                          width: 75,
                          child: TextField(
                            controller: _repititions,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 5.0),
                              ),
                              hintText: "Reps",
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 50,
                          width: 75,
                          child: TextField(
                            controller: _duration,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 5.0),
                              ),
                              hintText: "Length",
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 50,
                          width: 75,
                          child: TextField(
                            controller: _resistance,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 5.0),
                              ),
                              hintText: "Resist",
                            ),
                          )),
                    ])
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
                          fontSize: 18,
                          color: Colors.black),
                    ))),
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width / 2.5,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.green[900],
                    elevation: 2,
                  ),
                  child: Text(
                    'Confirm Edit',
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  )),
            )
          ]),
        ]));
  }
}
