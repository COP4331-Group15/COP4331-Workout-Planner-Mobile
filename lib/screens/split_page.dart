import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:large_project_app/screens/editExercises.dart';
import 'package:large_project_app/screens/editWorkout.dart';
import 'package:large_project_app/utils/communication.dart';
import 'package:large_project_app/widgets/appbar.dart';

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
  DateTime selectedDate = DateTime.now();
  Split splitD = new Split(-1, -1, -1, []);
  List<Workout> workouts = [];
  int? selectedWorkoutIndex;
  int? selectedExerciseIndex;
  Workout? selectedWorkout;
  Exercise? selectedExercise;
  int selectedState = 0; //0 none, 1 workout, 2 exercise

  @override
  void initState() {
    super.initState();
    debugPrint("Init state");
    //WidgetsBinding.instance?.addPostFrameCallback((_) =>
    Communication.getSplit().then((value) async {
      debugPrint("Loaded Split data");
      splitD = value;
      selectedDate = new DateTime(value.startYear, value.startMonth + 1,
          value.startDate, 0, 0, 0, 0, 0);
      for (String w_id in splitD.workouts) {
        debugPrint("Loading Workout data: " + w_id);
        Workout valueWorkout = await Communication.getWorkoutSpecific(w_id);
        debugPrint("Loaded Workout data: " + w_id);
        for (String e_id in valueWorkout.exercises) {
          Exercise valueExercise =
              await Communication.getExerciseSpecific(e_id);
          debugPrint("Loaded Excerise data: " + e_id);
          valueExercise.id = e_id;
          valueWorkout.exercisesContent.add(valueExercise);
        }
        valueWorkout.id = w_id;
        workouts.add(valueWorkout);
      }
      setState(() {}); //because it doesn't refresh. Please dont remove this
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

  List<DragAndDropItem> getDnDListExercises(Workout w, int indexW) {
    List<DragAndDropItem> thelist = [];
    w.exercisesContent.asMap().forEach((index, e) {
      thelist.add(DragAndDropItem(
        child: Container(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Text('   Exercise ' + (index + 1).toString() + ' : ' + e.name,
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black)),
                Expanded(child: Text("")),
                IconButton(
                  icon: const Icon(Icons.circle),
                  tooltip: 'Select',
                  color: e.iconColor,
                  onPressed: () {
                    setState(() {
                      //if (w.id == selectedWorkout?.id) {}
                      if (selectedState == 1) {
                        selectedState = 2;
                        selectedWorkout?.iconColor = Color(0xFF000000);
                        selectedExerciseIndex = index;
                        selectedExercise = e;
                        selectedWorkoutIndex = indexW;
                        selectedWorkout = w;
                        e.iconColor = Color(0xFF4CAF50);
                      } else {
                        selectedState = 2;
                        if (selectedExercise == null) {
                          selectedExerciseIndex = index;
                          selectedExercise = e;
                          selectedWorkoutIndex = indexW;
                          selectedWorkout = w;
                          e.iconColor = Color(0xFF4CAF50);
                        } else if (e.id != selectedExercise?.id) {
                          selectedExercise?.iconColor = Color(0xFF000000);
                          selectedExerciseIndex = index;
                          selectedExercise = e;
                          selectedWorkoutIndex = indexW;
                          selectedWorkout = w;
                          e.iconColor = Color(0xFF4CAF50);
                        } else {
                          selectedState = 0;
                          selectedExercise?.iconColor = Color(0xFF000000);
                          selectedExerciseIndex = null;
                          selectedExercise = null;
                          selectedWorkoutIndex = null;
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
      List<DragAndDropItem> anotherlist = getDnDListExercises(w, index);
      thelist.add(DragAndDropList(
        header: Container(
            height: 50,
            child: Row(
              children: [
                Text(' Workout Day ' + (index + 1).toString() + ' : ',
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black)),
                Expanded(child: Text("")),
                IconButton(
                  icon: const Icon(Icons.circle),
                  tooltip: 'Select',
                  color: w.iconColor,
                  onPressed: () {
                    setState(() {
                      if (selectedState == 2) {
                        selectedState = 1;
                        selectedExercise?.iconColor = Color(0xFF000000);
                        selectedExercise = null;
                        selectedWorkoutIndex = index;
                        selectedWorkout = w;
                        w.iconColor = Color(0xFF4CAF50);
                      } else {
                        selectedState = 1;
                        if (selectedWorkout == null) {
                          selectedWorkoutIndex = index;
                          selectedWorkout = w;
                          w.iconColor = Color(0xFF4CAF50);
                        } else if (w.id != selectedWorkout?.id) {
                          selectedWorkout?.iconColor = Color(0xFF000000);
                          selectedWorkoutIndex = index;
                          selectedWorkout = w;
                          w.iconColor = Color(0xFF4CAF50);
                        } else {
                          selectedState = 0;
                          selectedWorkout?.iconColor = Color(0xFF000000);
                          selectedWorkoutIndex = null;
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
      "startDate": splitD.startDate,
      "startMonth": splitD.startMonth,
      "startYear": splitD.startYear,
      "workouts": splitD.workouts,
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
        splitD.startDate = selectedDate.day;
        splitD.startMonth = selectedDate.month - 1;
        splitD.startYear = selectedDate.year;
        updateSplit();
      });
    }
  }

  Widget build(BuildContext context) {
    _contents = allListfunc();
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context); //, workouts);
        return new Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(),
        ),
        body: Column(children: [
          Container(
              height: 100,
              color: Color(0xFF282c34),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                      height: 50,
                      color: Color(0xFF494c54),
                      child: Row(children: <Widget>[
                        Container(width: 10),
                        Center(
                            child: Text("Wo:",
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black))),
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
                                    Workout selectedWorkout2 =
                                        selectedWorkout ??
                                            new Workout(0, 0, []);
                                    selectedWorkout = null;
                                    selectedWorkoutIndex = null;
                                    setState(() {
                                      Communication.deleteWorkout(
                                              selectedWorkout2.id)
                                          .then((value) {
                                        setState(() {
                                          splitD.workouts.removeWhere(
                                              (w) => w == selectedWorkout2.id);
                                          workouts.removeWhere((w) =>
                                              w.id == selectedWorkout2.id);
                                          updateSplit();
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
                              Workout newWorkout = new Workout(0, 0, []);
                              Map data = {
                                "startTime": newWorkout.startTime,
                                "unworkable": newWorkout.unworkable,
                                "exercises": newWorkout.exercises
                              };
                              Communication.postWorkout(data).then((value) {
                                setState(() {
                                  newWorkout.id = value;
                                  workouts.add(newWorkout);
                                  splitD.workouts.add(newWorkout.id);
                                  updateSplit();
                                });
                              });
                            });
                          },
                        ),
                        Center(
                            child: Text("Ex:",
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black))),
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
                                    selectedExercise = null;
                                    selectedExerciseIndex = null;
                                    Workout selectedWorkout2 =
                                        selectedWorkout ??
                                            new Workout(0, 0, []);
                                    setState(() {
                                      Communication.deleteExercise(
                                              selectedExercise2.id)
                                          .then((value) {
                                        setState(() {
                                          selectedWorkout2.exercises
                                              .removeWhere((e) =>
                                                  e == selectedExercise2.id);
                                          selectedWorkout2.exercisesContent
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
                                  selectedWorkout ?? new Workout(0, 0, []);
                              setState(() {
                                Exercise newExercise = new Exercise(
                                    "", "New Exercise", 0, 0, 0, 0);
                                Map data = {
                                  "muscleGroup": newExercise.muscleGroup,
                                  "name": newExercise.name,
                                  "sets": newExercise.sets,
                                  "repetitions": newExercise.repetitions,
                                  "duration": newExercise.duration,
                                  "resistance": newExercise.resistance
                                };
                                Communication.postExercise(data).then((value) {
                                  setState(() {
                                    newExercise.id = value;
                                    selectedWorkout2.exercises
                                        .add(newExercise.id);
                                    selectedWorkout2.exercisesContent
                                        .add(newExercise);
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
                      ])),
                  ElevatedButton(
                      onPressed: () async {
                        if (selectedState == 1) {
                          selectedWorkout = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditWorkoutPage(
                                    selectedWorkout ?? new Workout(0, 0, []))),
                          );
                          workouts[selectedWorkoutIndex ?? -1] =
                              selectedWorkout ?? new Workout(0, 0, []);
                          setState(() {});
                        } else if (selectedState == 2) {
                          selectedExercise = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditExercisePage(
                                    selectedExercise ??
                                        new Exercise("", "", 0, 0, 0, 0))),
                          );
                          workouts[selectedWorkoutIndex ?? -1].exercisesContent[
                                  selectedExerciseIndex ?? -1] =
                              selectedExercise ??
                                  new Exercise("", "", 0, 0, 0, 0);
                          setState(() {});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.green[900],
                        elevation: 2,
                      ),
                      child: Text(
                        'Edit Selected',
                        style: TextStyle(
                            fontFamily: 'Georgia',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      )),
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
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = workouts[oldListIndex].exercises.removeAt(oldItemIndex);
      var movedItem2 =
          workouts[oldListIndex].exercisesContent.removeAt(oldItemIndex);
      workouts[newListIndex].exercises.insert(newItemIndex, movedItem);
      workouts[newListIndex].exercisesContent.insert(newItemIndex, movedItem2);
      updateWorkout(workouts[newListIndex]);
      updateWorkout(workouts[oldListIndex]);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = workouts.removeAt(oldListIndex);
      workouts.insert(newListIndex, movedList);
      var movedList2 = splitD.workouts.removeAt(oldListIndex);
      splitD.workouts.insert(newListIndex, movedList2);
      updateSplit();
    });
  }
}
