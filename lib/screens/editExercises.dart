import 'package:flutter/material.dart';
import 'package:large_project_app/data/exercise.dart';
import 'package:large_project_app/widgets/appbar.dart';
import 'package:large_project_app/utils/communication.dart';

class EditExercisePage extends StatefulWidget {
  final Exercise selectedExercise;
  EditExercisePage(this.selectedExercise);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditExercisePage> {
  bool isChecked = false;
  final TextEditingController _muscleGroup = new TextEditingController();
  final TextEditingController _exerciseName = new TextEditingController();
  final TextEditingController _sets = new TextEditingController();
  final TextEditingController _repetitions = new TextEditingController();
  final TextEditingController _duration = new TextEditingController();
  final TextEditingController _resistance = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _exerciseName.text = widget.selectedExercise.name;
    _muscleGroup.text = widget.selectedExercise.muscleGroup;
    _sets.text = widget.selectedExercise.sets.toString();
    _repetitions.text = widget.selectedExercise.repetitions.toString();
    _duration.text = widget.selectedExercise.duration.toString();
    _resistance.text = widget.selectedExercise.resistance.toString();
  }

  Future<Exercise> updateExercise() async {
    Map data = {
      "muscleGroup": _muscleGroup.text,
      "name": _exerciseName.text,
      "sets": int.parse(_sets.text),
      "repetitions": int.parse(_repetitions.text),
      "duration": int.parse(_duration.text),
      "resistance": int.parse(_resistance.text)
    };
    await Communication.patchExercise(data, widget.selectedExercise.id);
    Exercise e = new Exercise(
        _muscleGroup.text,
        _exerciseName.text,
        int.parse(_sets.text),
        int.parse(_repetitions.text),
        int.parse(_duration.text),
        int.parse(_resistance.text));
    e.id = widget.selectedExercise.id;
    e.iconColor = widget.selectedExercise.iconColor;
    return e;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, widget.selectedExercise);
          return new Future(() => true);
        },
        child: Scaffold(
            appBar: AppBar(title: CustomAppBar()),
            body: Column(children: [
              Expanded(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(2),
                      children: [
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
                              bottom:
                                  BorderSide(color: Colors.black, width: 2))),
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
                                  color: Theme.of(context).accentColor,
                                  width: 5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 5.0),
                            ),
                            hintText: "Exercise name",
                          ),
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
                                  color: Theme.of(context).accentColor,
                                  width: 5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 5.0),
                            ),
                            hintText: "Muscle group",
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
                                controller: _repetitions,
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
                        ]),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                              child: Image.asset('assets/calendar.png',
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height:
                                      MediaQuery.of(context).size.width / 2.5),
                            ),
                          ],
                        )),
                  ])),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                    margin: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, widget.selectedExercise);
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
                      onPressed: () async {
                        Navigator.pop(context, await updateExercise());
                      },
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
            ])));
  }
}
