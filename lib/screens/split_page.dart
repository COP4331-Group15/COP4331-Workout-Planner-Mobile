import 'dart:ui';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:large_project_app/utils/communication.dart';

import 'package:large_project_app/data/exercise.dart';
import 'package:large_project_app/data/split.dart';
import 'package:large_project_app/data/workout.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class SplitPage extends StatefulWidget {
  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  List<DragAndDropList> _contents = [];
  //final TextEditingController _email = new TextEditingController();
  //final TextEditingController _password = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  Split Split_d = new Split(-1, -1, -1, []);
  List<Workout> workouts = [];
  List<Color> w_colors = [];
  Workout? selectedWorkout;
  Exercise? selectedExercise;

  @override
  void initState() {
    super.initState();
    debugPrint("Init state");
    //WidgetsBinding.instance?.addPostFrameCallback((_) =>
    Communication.getSplit().then((value) {
      setState(() {
        debugPrint("Loaded Split data");
        Split_d = value;
        selectedDate = new DateTime(value.startYear, value.startMonth + 1,
            value.startDate, 0, 0, 0, 0, 0);
        for (String w_id in Split_d.workouts) {
          debugPrint("Loading Workout data: " + w_id);
          Communication.getWorkoutSpecific(w_id).then((value_w) {
            setState(() {
              debugPrint("Loaded Workout data: " + w_id);
              for (String e_id in value_w.exercises) {
                Communication.getExerciseSpecific(e_id).then((value_e) {
                  setState(() {
                    debugPrint("Loaded Excerise data: " + e_id);
                    value_e.id = e_id;
                    value_w.exercises_content.add(value_e);
                  });
                });
              }
              value_w.id = w_id;
              workouts.add(value_w);
            });
          });
        }
      });
    });
  }

  List<DragAndDropItem> getDnDListExercises(int index) {
    List<DragAndDropItem> thelist = [];
    workouts[index].exercises.forEach((e) {
      thelist.add(DragAndDropItem(
        child: Container(
            height: 30, width: double.infinity, child: Text('sgytgtffffff')),
      ));
    });
    return thelist;
  }

  List<DragAndDropList> allListfunc() {
    List<DragAndDropList> thelist = [];
    debugPrint("lvoe: " + workouts.toString());
    workouts.asMap().forEach((index, w) {
      List<DragAndDropItem> anotherlist = getDnDListExercises(index);
      thelist.add(DragAndDropList(
        header: Container(
            height: 50,
            child: Row(
              children: [
                Text('Header : $index'),
                Expanded(child: Text("")),
                IconButton(
                  icon: const Icon(Icons.circle),
                  tooltip: 'Select',
                  color: w.icon_color,
                  onPressed: () {
                    setState(() {
                      if (selectedWorkout == null) {
                        selectedWorkout = w;
                        w.icon_color = Color(0xFF4CAF50);
                      } else if (w.id != selectedWorkout?.id) {
                        selectedWorkout?.icon_color = Color(0xFF000000);
                        selectedWorkout = w;
                        w.icon_color = Color(0xFF4CAF50);
                      } else {
                        selectedWorkout?.icon_color = Color(0xFF000000);
                        selectedWorkout = null;
                      }
                    });
                  },
                )
              ],
            )),
        children: anotherlist,
      ));
    });
    return thelist;
    // workouts.map(return DragAndDropItem(
    //         child: Container(
    //             height: 30, width: double.infinity, child: Text('sutsuthstuhst)),
    //       );).toList()
  }

  void updateSplit() {
    Map data = {
      "startDate": Split_d.startDate,
      "startMonth": Split_d.startMonth,
      "startYear": Split_d.startYear,
      "workouts": Split_d.workouts,
    };
    Communication.patchSplit(data);
  }

  void updateWorkout(Workout w) {
    Map data = {
      "startTime": w.startTime,
      "unworkable": w.unworkable,
      "exercises": w.exercises
    };
    Communication.patchWorkout(data, w.id);
  }

  void updateExercise(Exercise e) {
    Map data = {
      "muscleGroup": e.muscleGroup,
      "name": e.name,
      "sets": e.sets,
      "repititions": e.repititions,
      "duration": e.duration,
      "resistance": e.resistance
    };
    Communication.patchWorkout(data, e.id);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Split_d.startDate = selectedDate.day;
        Split_d.startMonth = selectedDate.month - 1;
        Split_d.startYear = selectedDate.year;
        updateSplit();
      });
    }
  }

  int _count = 0;
  Widget build(BuildContext context) {
    _contents = allListfunc();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Page'),
      ),
      body: Column(children: [
        Container(
            height: 300,
            color: Color(0xFF282c34),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(child: Text("hello!")),
                Container(
                    height: 50,
                    color: Color(0xFF494c54),
                    child: Row(children: <Widget>[
                      Center(child: Text("Workout:")),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        tooltip: 'Delete Workout',
                        onPressed: () {
                          Widget cancelButton = TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget continueButton = TextButton(
                            child: Text("Delete"),
                            onPressed: () {
                              setState(() {
                                if (selectedWorkout != null) {
                                  Workout selectedWorkout2 = selectedWorkout ??
                                      new Workout(2667, false, []);
                                  setState(() {
                                    Communication.deleteWorkout(
                                            selectedWorkout2.id)
                                        .then((value) {
                                      setState(() {
                                        Split_d.workouts.removeWhere(
                                            (w) => w == selectedWorkout2.id);
                                        workouts.removeWhere(
                                            (w) => w.id == selectedWorkout2.id);
                                        updateSplit();
                                        Navigator.pop(context);
                                      });
                                    });
                                  });
                                }
                              });
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Delete Workout"),
                            content: Text(
                                "Do you want to delete the selected workout?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: 'Add Workout',
                        onPressed: () {
                          setState(() {
                            Workout w_new = new Workout(0, false, []);
                            Map data = {
                              "startTime": w_new.startTime,
                              "unworkable": w_new.unworkable,
                              "exercises": w_new.exercises
                            };
                            Communication.postWorkout(data).then((value) {
                              setState(() {
                                w_new.id = value;
                                workouts.add(w_new);
                                Split_d.workouts.add(w_new.id);
                                updateSplit();
                              });
                            });
                          });
                        },
                      ),
                      Center(child: Text("Exercise:")),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        tooltip: 'Delete Exercise',
                        onPressed: () {
                          debugPrint("Deletebutttex");
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: 'Add Exercise',
                        onPressed: () {
                          debugPrint("adddddbutex");
                          if (selectedWorkout != null) {
                            Workout selectedWorkout2 =
                                selectedWorkout ?? new Workout(0, false, []);
                            setState(() {
                              Exercise e_new = new Exercise("", "", 0, 0, 0, 0);
                              Map data = {
                                "muscleGroup": e_new.muscleGroup,
                                "name": e_new.name,
                                "sets": e_new.sets,
                                "repititions": e_new.repititions,
                                "duration": e_new.duration,
                                "resistance": e_new.resistance
                              };
                              Communication.postExercise(data).then((value) {
                                setState(() {
                                  e_new.id = value;
                                  selectedWorkout2.exercises.add(e_new.id);
                                  selectedWorkout2.exercises_content.add(e_new);
                                  updateWorkout(selectedWorkout2);
                                });
                              });
                            });
                          }
                        },
                      ),
                      Expanded(child: Text("")),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        tooltip: 'Change split start date',
                        onPressed: () {
                          setState(() {
                            _selectDate(context);
                          });
                        },
                      )
                    ]))
              ],
            )),
        Expanded(
          child: DragAndDropLists(
            //color: Color(0xFF282c34),
            children: _contents,
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
          ),
        ),
        Text('You have pressed the button $_count times.')
      ]),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => {_count++});
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
