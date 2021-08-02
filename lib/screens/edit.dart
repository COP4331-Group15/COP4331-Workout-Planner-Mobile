import 'package:flutter/material.dart';
import 'package:large_project_app/widgets/appbar.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _startHour = new TextEditingController();
  final TextEditingController _startMinute = new TextEditingController();
  bool isChecked = false;
  bool isAM = false;
  bool isPM = true;
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
                  margin: EdgeInsets.all(5),
                  child: Text("Edit Workout",
                      style: TextStyle(
                        fontFamily: "ChunkFive",
                        fontSize: 20,
                      )),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2))),
                )),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 75,
                      width: 75,
                      child: TextField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        controller: _startHour,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
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
                          hintText: "Hour",
                        ),
                      )),
                  Center(
                      child: Container(
                          height: 50,
                          child: Text(":",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ChunkFive",
                                  fontSize: 20)))),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 75,
                      width: 75,
                      child: TextField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        controller: _startMinute,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
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
                          hintText: "Min",
                        ),
                      )),
                  Center(
                      child: Container(
                          height: 50,
                          child: Text("AM:", style: TextStyle(fontSize: 15)))),
                  Container(
                      child: Checkbox(
                          value: isAM,
                          onChanged: (bool? value) {
                            setState(() {
                              isPM = false;
                              isAM = true;
                            });
                          })),
                  Center(
                      child: Container(
                          height: 50,
                          child: Text("PM:", style: TextStyle(fontSize: 15)))),
                  Container(
                      child: Checkbox(
                          value: isPM,
                          onChanged: (bool? value) {
                            setState(() {
                              isPM = true;
                              isAM = false;
                            });
                          }))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      margin: const EdgeInsets.all(10.0),
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
                  margin: EdgeInsets.all(5),
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
                    height: 75,
                    child: TextField(
                      maxLength: 25,
                      controller: _muscleGroup,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
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
                    height: 75,
                    child: TextField(
                      maxLength: 25,
                      controller: _exerciseName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
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
                          height: 75,
                          width: 75,
                          child: TextField(
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            controller: _sets,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
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
                          height: 75,
                          width: 75,
                          child: TextField(
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            controller: _repititions,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
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
                          height: 75,
                          width: 75,
                          child: TextField(
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            controller: _duration,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
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
                          height: 75,
                          width: 75,
                          child: TextField(
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            controller: _resistance,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
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
