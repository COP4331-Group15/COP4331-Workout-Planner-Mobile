import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:large_project_app/data/calendar.dart';
import 'package:large_project_app/data/exercise.dart';
import 'package:large_project_app/data/workout.dart';
import 'package:large_project_app/utils/communication.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/utils.dart';
import 'split_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<CalendarPage> {
  late final ValueNotifier<Workout> _selectedWorkouts;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Calendar? userCalendar;
  List<Exercise>? _exercises;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedWorkouts = ValueNotifier(_getWorkoutPerDay(_selectedDay!));
    Communication.getCalendar(_focusedDay.year, _focusedDay.month - 1)
        .then((value) => setState(() {
              userCalendar = value;
            }));
  }

  Workout _getWorkoutPerDay(DateTime day) {
    // Implementation example
    if (userCalendar != null) {
      return userCalendar!.days[day.day - 1];
    }

    return Workout(0, true, []);
  }

  List<Exercise> _getExercisePerDay(DateTime day) {
    Workout dayWorkout = _getWorkoutPerDay(day);
    refreshExercises(dayWorkout, day).then((value) => setState(() {
          dayWorkout.exercisesContent = value;
        }));
    return dayWorkout.exercisesContent;
  }

  Future<List<Exercise>> refreshExercises(
      Workout dayWorkout, DateTime day) async {
    List<Exercise> exercises;
    if (dayWorkout.id.isEmpty) {
      // This workout is day specific.
      exercises =
          await Communication.getExercisesPerDate(day.year, day.month, day.day);
    } else {
      // This workout is generic.
      exercises = await Communication.getExercisesPerWorkout(dayWorkout.id);
    }

    return exercises;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedWorkouts.value = _getWorkoutPerDay(selectedDay);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplitPage()),
                );
              } else if (result == 1) {
                await FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
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
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Column(children: [
              Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.green[900],
                      elevation: 10,
                    ),
                    onPressed: () {},
                  )),
              Expanded(
                child: ValueListenableBuilder<Workout>(
                  valueListenable: _selectedWorkouts,
                  builder: (context, value, _) {
                    return Text("${value.startTime}");
                    //return ListView.builder(
                    /* itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 0,
                                  primary: Colors.white),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('${value[index]}',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: ElevatedButton(
                                        child: Icon(Icons.close),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[300],
                                          onPrimary: Colors.grey[400],
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ]),
                            )); */
                    //},
                    //);
                  },
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
