import 'package:large_project_app/data/exercise.dart';
import 'dart:ui';

class Workout {
  int startTime;
  int unworkable;

  List<String> exercises;
  String id = "";
  Color iconColor = Color(0xFF000000);
  List<Exercise> exercisesContent = [];

  Workout(this.startTime, this.unworkable, this.exercises, {this.id = ""});

  factory Workout.fromJSON(Map json) {
    return new Workout(json["StartTime"] ?? 0, json["Unworkable"] ?? 0,
        json["Exercises"]?.cast<String>() ?? [],
        id: json["Key"] ?? "");
  }

  Map toJson() {
    return {
      "startTime": this.startTime,
      "exercises": this.exercises,
      "unworkable": this.unworkable
    };
  }
}
