import 'package:large_project_app/data/exercise.dart';
import 'dart:ui';

class Workout {
  int startTime;
  int unworkable;

  List<String> exercises = [];
  String id = "";
  Color iconColor = Color(0xFF000000);
  List<Exercise> exercisesContent = [];

  Workout(this.startTime, this.unworkable, this.exercises);

  factory Workout.fromJSON(Map json) {
    if (json["Exercises"] == null) {
      return new Workout(json["StartTime"], json["Unworkable"], []);
    } else {
      return new Workout(json["StartTime"], json["Unworkable"],
          json["Exercises"].cast<String>());
    }
  }

  Map toJson() {
    return {
      "startDate": this.startTime,
      "startMonth": this.unworkable,
      "workouts": this.exercises,
    };
  }
}
