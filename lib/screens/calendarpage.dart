import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:large_project_app/data/calendar.dart';
import 'package:large_project_app/utils/communication.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/utils.dart';

import 'edit.dart';
import 'split_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Calendar? userCalendar;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    Communication.getSplit().then((value) => print(value));
    Communication.getExerciseUser().then((value) => print(value));
    Communication.getWorkoutUser().then((value) => print(value));
    Communication.getCalendar(_focusedDay.year, _focusedDay.month - 1)
        .then((value) => setState(() {
              userCalendar = value;
            }));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
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
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
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
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditPage()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0, primary: Colors.white),
                                      child: Text('${value[index]}',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    child: Icon(Icons.close),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                      onPrimary: Colors.green[900],
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
                                )
                              ]),
                        );
                      },
                    );
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
