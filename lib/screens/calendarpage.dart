import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:large_project_app/data/calendar.dart';
import 'package:large_project_app/data/exercise.dart';
import 'package:large_project_app/data/workout.dart';
import 'package:large_project_app/screens/editExercises.dart';
import 'package:large_project_app/utils/communication.dart';
import 'package:large_project_app/widgets/appbar.dart';
import 'package:large_project_app/widgets/exercise_list_entry.dart';
import 'package:large_project_app/widgets/workout_edit_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/utils.dart';
import 'split_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<CalendarPage> {
  StreamController<List<Exercise>?> _exerciseStream =
      StreamController<List<Exercise>?>();
  late final Stream<List<Exercise>?> _exercises;
  late final ValueNotifier<Workout> _selectedWorkouts;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Calendar? userCalendar;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedWorkouts = ValueNotifier(_getWorkoutPerDay(_selectedDay!));
    _exercises = _exerciseStream.stream;
    Communication.getCalendar(_focusedDay.year, _focusedDay.month - 1)
        .then((value) => setState(() {
              userCalendar = value;
              refreshExercises();
            }));
  }

  Workout _getWorkoutPerDay(DateTime day) {
    // Implementation example
    if (userCalendar != null) {
      return userCalendar!.days[day.day - 1];
    }

    return Workout(0, 0, []);
  }

  List<Exercise> _getExercisePerDay(DateTime day) {
    Workout dayWorkout = _getWorkoutPerDay(day);
    return dayWorkout.exercisesContent;
  }

  Future<List<Exercise>> refreshExercises() async {
    // Clear the existing exercises
    _exerciseStream.add(null);

    Workout dayWorkout = _getWorkoutPerDay(_selectedDay!);
    DateTime day = _selectedDay!;

    List<Exercise> exercises;
    if (dayWorkout.id.isEmpty) {
      // This workout is day specific.
      exercises = await Communication.getExercisesPerDate(
          day.year, day.month - 1, day.day);
    } else {
      // This workout is generic.
      exercises = await Communication.getExercisesPerWorkout(dayWorkout.id);
    }
    // Update the stream with the new data
    _exerciseStream.add(exercises);

    return exercises;
  }

  void _refreshCalendar() async {
    Communication.getCalendar(_focusedDay.year, _focusedDay.month - 1)
        .then((value) => setState(() {
              userCalendar = value;
              refreshExercises();
            }));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedWorkouts.value = _getWorkoutPerDay(selectedDay);
      refreshExercises();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text("Split"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Logout"),
              ),
            ],
            onSelected: (result) async {
              if (result == 0) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplitPage()),
                );
                _refreshCalendar();
              } else if (result == 1) {
                await FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
        title: CustomAppBar(),
      ),
      body: Column(
        children: [
          TableCalendar<Exercise>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getExercisePerDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              _refreshCalendar();
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          "${_getWorkoutPerDay(_focusedDay).id.isEmpty ? "Custom " : ""}Workout on ${_selectedDay!.month}/${_selectedDay!.day}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontWeight: (_getWorkoutPerDay(_focusedDay)
                                          .id
                                          .isEmpty)
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed:
                                  (_getWorkoutPerDay(_focusedDay).id.isEmpty)
                                      ? _onEditWorkoutPressed
                                      : null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          onPrimary: Colors.green[900],
                          elevation: 10,
                        ),
                        onPressed: _onAddPressed,
                      )),
                  Expanded(
                    // Update the following contents whenever the selected workout changes...
                    child: ValueListenableBuilder<Workout>(
                      valueListenable: _selectedWorkouts,
                      builder: (context, value, _) {
                        // Update the following contents whenever the exercises list is loaded
                        return StreamBuilder<List<Exercise>?>(
                            stream: _exercises,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                  "Error loading exercises: ${snapshot.error}",
                                  textAlign: TextAlign.center,
                                );
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Text(
                                  "Loading Exercises",
                                  textAlign: TextAlign.center,
                                );
                              }
                              return ListView.builder(
                                itemCount: value.exercises.length,
                                itemBuilder: (context, index) {
                                  if (index >= snapshot.data!.length) {
                                    return Container();
                                  }
                                  return ExerciseListEntry(
                                      onDelete: () => _onDeletePressed(context,
                                          value, snapshot.data![index].id),
                                      onTapped: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditExercisePage(
                                                        snapshot.data![index])),
                                          ),
                                      title: '${snapshot.data?[index].name}');
                                },
                              );
                            });
                      },
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  void _onEditWorkoutPressed() async {
    Workout currentWorkout = _getWorkoutPerDay(_focusedDay);
    WorkoutEditDialogResult? result = await showDialog(
        context: context,
        builder: (BuildContext context) => WorkoutEditDialog(
            initialStartTime: currentWorkout.startTime,
            initialUnworkable: currentWorkout.unworkable));

    if (result == null) return;

    // We have some updates to the workout
    currentWorkout = _getWorkoutPerDay(_focusedDay);
    setState(() {
      currentWorkout.startTime = result.startTime;
      currentWorkout.unworkable = result.unworkable;
    });

    await Communication.patchDateSpecificWorkout(currentWorkout.toJson(),
        _focusedDay.year, _focusedDay.month - 1, _focusedDay.day);

    _refreshCalendar();
  }

  void _onAddPressed() async {
    Workout value = _getWorkoutPerDay(_selectedDay!);
    bool isNewWorkout = value.id.isNotEmpty;

    if (isNewWorkout) {
      value = Workout(0, 0, []);
    }
    Exercise newExercise =
        new Exercise("", "New Date Specific Exercise", 0, 0, 0, 0);
    String exerciseId = await Communication.postExercise(newExercise.toJson());
    value.exercises.add(exerciseId);

    await Communication.patchDateSpecificWorkout(value.toJson(),
        _selectedDay!.year, _selectedDay!.month - 1, _selectedDay!.day);

    _refreshCalendar();
  }

  void _onDeletePressed(
      BuildContext context, Workout workout, String? exerciseId) async {
    if (workout.id.isNotEmpty) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(
                  "Cannot Delete",
                  textAlign: TextAlign.center,
                ),
                content: Text(
                    "Exercise is not date specific, Edit this workout in the Split Editor"));
          });
      return;
    } else {
      if (exerciseId == null) {
        return;
      }

      await Communication.deleteExercise(exerciseId);
      workout.exercises.remove(exerciseId);

      if (workout.exercises.isEmpty) {
        // We've now deleted all exercises for this workout. Delete the workout
        await Communication.deleteDateSpecificWorkout(
            _selectedDay!.year, _selectedDay!.month - 1, _selectedDay!.day);
      } else {
        // We still have something in the exercises list. Let it exist.
        await Communication.patchDateSpecificWorkout(workout.toJson(),
            _selectedDay!.year, _selectedDay!.month - 1, _selectedDay!.day);
      }
    }
  }
}
