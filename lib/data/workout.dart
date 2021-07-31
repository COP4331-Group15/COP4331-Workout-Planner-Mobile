class Workout {
  String startTime;
  bool unworkable;

  List<String> exercises;

  Workout(this.startTime, this.unworkable, this.exercises);

  factory Workout.fromJSON(Map json) {
    return new Workout(json["StartTime"], json["Unworkable"],
        json["Exercises"].cast<String>());
  }

  Map toJson() {
    return {
      "startDate": this.startTime,
      "startMonth": this.unworkable,
      "workouts": this.exercises,
    };
  }
}
