import 'dart:collection';

import 'package:large_project_app/data/workout.dart';
import 'package:table_calendar/table_calendar.dart';

var kWorkouts = LinkedHashMap<DateTime, List<Workout>>(
  equals: isSameDay,
);

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 1, kToday.month, kToday.day);
