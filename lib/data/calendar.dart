import 'package:large_project_app/data/workout.dart';

class Calendar {
  List<Workout> days;

  Calendar(this.days);

  factory Calendar.fromJSON(Map json) {
    List<Workout> hold = [];
    for (Map? mapper in json["calendar"]) {
      hold.add(Workout.fromJSON(mapper ?? {}));
    }
    return new Calendar(hold);
  }
}
