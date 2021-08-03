import 'package:flutter/material.dart';
import 'package:large_project_app/data/workout.dart';
import 'package:large_project_app/utils/communication.dart';
import 'package:large_project_app/widgets/appbar.dart';

class EditWorkoutPage extends StatefulWidget {
  final Workout selectedWorkout;
  EditWorkoutPage(this.selectedWorkout);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditWorkoutPage> {
  final TextEditingController _startHour = new TextEditingController();
  final TextEditingController _startMinute = new TextEditingController();
  bool isChecked = false;
  bool isAM = false;
  bool isPM = true;
  @override
  void initState() {
    super.initState();
    int startTime = 0;
    if (widget.selectedWorkout.startTime > (60 * 12)) {
      startTime = widget.selectedWorkout.startTime - (60 * 12);
      _startHour.text = ((startTime / 60).floor()).toString();
      _startMinute.text = (startTime % 60).toString();
      isAM = false;
      isPM = true;
    } else {
      startTime = widget.selectedWorkout.startTime;
      _startHour.text = ((startTime / 60).floor()).toString();
      _startMinute.text = (startTime % 60).toString();
      isAM = true;
      isPM = false;
    }
    if (widget.selectedWorkout.unworkable == 1) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }

  Future<Workout> updateWorkout() async {
    int addnum = 0;
    if (isPM) {
      addnum = 60 * 12;
    }
    int booly = 0;
    if (isChecked) {
      booly = 1;
    }
    addnum =
        int.parse(_startHour.text) * 60 + int.parse(_startMinute.text) + addnum;
    Map data = {
      "startTime": addnum,
      "unworkable": booly,
      "exercises": widget.selectedWorkout.exercises
    };
    await Communication.patchWorkout(data, widget.selectedWorkout.id);
    Workout w = Workout(addnum, booly, widget.selectedWorkout.exercises);
    w.id = widget.selectedWorkout.id;
    w.exercisesContent = widget.selectedWorkout.exercisesContent;
    w.iconColor = widget.selectedWorkout.iconColor;
    return w;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, widget.selectedWorkout);
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
                            child:
                                Text("AM:", style: TextStyle(fontSize: 15)))),
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
                            child:
                                Text("PM:", style: TextStyle(fontSize: 15)))),
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
                            child: Image.asset('assets/calendar.png',
                                width: MediaQuery.of(context).size.width / 2.5,
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
                        Navigator.pop(context, widget.selectedWorkout);
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
                      Navigator.pop(context, await updateWorkout());
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
          ])),
    );
  }
}
