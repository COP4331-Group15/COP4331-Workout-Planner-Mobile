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
  Workout? selectedWorkout;
  Exercise? selectedExercise;
  int selectedState = 0; //0 none, 1 workout, 2 exercise

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

  Expanded getTopEdit() {
    if (selectedState == 0) {
      return Expanded(child: Text("Split"));
    } else if (selectedState == 1) {
      return Expanded(child: Text("Workout"));
    } else if (selectedState == 2) {
      return Expanded(child: Text("Exercise"));
    }
    return Expanded(child: Text("Error"));
  }

  List<DragAndDropItem> getDnDListExercises(Workout w) {
    List<DragAndDropItem> thelist = [];
    w.exercises_content.asMap().forEach((index, e) {
      thelist.add(DragAndDropItem(
        child: Container(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Text('Header exercise : $index'),
                Expanded(child: Text("")),
                IconButton(
                  icon: const Icon(Icons.circle),
                  tooltip: 'Select',
                  color: e.icon_color,
                  onPressed: () {
                    setState(() {
                      //if (w.id == selectedWorkout?.id) {}
                      if (selectedState == 1) {
                        selectedState = 2;
                        selectedWorkout?.icon_color = Color(0xFF000000);
                        selectedExercise = e;
                        selectedWorkout = w;
                        e.icon_color = Color(0xFF4CAF50);
                      } else {
                        selectedState = 2;
                        if (selectedExercise == null) {
                          selectedExercise = e;
                          selectedWorkout = w;
                          e.icon_color = Color(0xFF4CAF50);
                        } else if (e.id != selectedExercise?.id) {
                          selectedExercise?.icon_color = Color(0xFF000000);
                          selectedExercise = e;
                          selectedWorkout = w;
                          e.icon_color = Color(0xFF4CAF50);
                        } else {
                          selectedState = 0;
                          selectedExercise?.icon_color = Color(0xFF000000);
                          selectedExercise = null;
                          selectedWorkout = null;
                        }
                      }
                    });
                  },
                )
              ],
            )),
      ));
    });
    return thelist;
  }

  List<DragAndDropList> allListfunc() {
    List<DragAndDropList> thelist = [];
    workouts.asMap().forEach((index, w) {
      List<DragAndDropItem> anotherlist = getDnDListExercises(w);
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
                      if (selectedState == 2) {
                        selectedState = 1;
                        selectedExercise?.icon_color = Color(0xFF000000);
                        selectedExercise = null;
                        selectedWorkout = w;
                        w.icon_color = Color(0xFF4CAF50);
                      } else {
                        selectedState = 1;
                        if (selectedWorkout == null) {
                          selectedWorkout = w;
                          w.icon_color = Color(0xFF4CAF50);
                        } else if (w.id != selectedWorkout?.id) {
                          selectedWorkout?.icon_color = Color(0xFF000000);
                          selectedWorkout = w;
                          w.icon_color = Color(0xFF4CAF50);
                        } else {
                          selectedState = 0;
                          selectedWorkout?.icon_color = Color(0xFF000000);
                          selectedWorkout = null;
                        }
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
      "repetitions": e.repetitions,
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
                                if (selectedWorkout != null &&
                                    selectedState == 1) {
                                  Workout selectedWorkout2 = selectedWorkout ??
                                      new Workout(0, false, []);
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
                                if (selectedExercise != null &&
                                    selectedWorkout != null &&
                                    selectedState == 2) {
                                  Exercise selectedExercise2 =
                                      selectedExercise ??
                                          new Exercise("", "", 0, 0, 0, 0);
                                  Workout selectedWorkout2 = selectedWorkout ??
                                      new Workout(0, false, []);
                                  setState(() {
                                    Communication.deleteExercise(
                                            selectedExercise2.id)
                                        .then((value) {
                                      setState(() {
                                        selectedWorkout2.exercises.removeWhere(
                                            (e) => e == selectedExercise2.id);
                                        selectedWorkout2.exercises_content
                                            .removeWhere((e) =>
                                                e.id == selectedExercise2.id);
                                        updateWorkout(selectedWorkout2);
                                        Navigator.pop(context);
                                      });
                                    });
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Delete Exercise"),
                            content: Text(
                                "Do you want to delete the selected exercise?"),
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
                        tooltip: 'Add Exercise',
                        onPressed: () {
                          if (selectedWorkout != null) {
                            Workout selectedWorkout2 =
                                selectedWorkout ?? new Workout(0, false, []);
                            setState(() {
                              Exercise e_new = new Exercise("", "", 0, 0, 0, 0);
                              Map data = {
                                "muscleGroup": e_new.muscleGroup,
                                "name": e_new.name,
                                "sets": e_new.sets,
                                "repetitions": e_new.repetitions,
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
        )
      ]),
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() => {_count++});
      //   },
      //   tooltip: 'Increment Counter',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = workouts[oldListIndex].exercises.removeAt(oldItemIndex);
      var movedItem2 =
          workouts[oldListIndex].exercises_content.removeAt(oldItemIndex);
      workouts[newListIndex].exercises.insert(newItemIndex, movedItem);
      workouts[newListIndex].exercises_content.insert(newItemIndex, movedItem2);
      updateWorkout(workouts[newListIndex]);
      updateWorkout(workouts[oldListIndex]);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = workouts.removeAt(oldListIndex);
      workouts.insert(newListIndex, movedList);
      updateSplit();
    });
  }
}
