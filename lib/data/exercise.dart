import 'dart:ui';

class Exercise {
  String muscleGroup;
  String name;
  int sets;
  int repetitions;
  int duration;
  int resistance;

  String id = "";
  Color iconColor = Color(0xFF000000);

  Exercise(this.muscleGroup, this.name, this.sets, this.repetitions,
      this.duration, this.resistance,
      {this.id = ""});

  factory Exercise.fromJSON(Map json) {
    return new Exercise(
        json["MuscleGroup"] ?? 0,
        json["Name"] ?? "",
        json["Sets"] ?? 0,
        json["Repetitions"] ?? 0,
        json["Duration"] ?? 0,
        json["Resistance"] ?? 0,
        id: json["Key"] ?? "");
  }

  Map toJson() {
    return {
      "muscleGroup": this.muscleGroup,
      "name": this.name,
      "sets": this.sets,
      "repetitions": this.repetitions,
      "duration": this.duration,
      "resistance": this.resistance
    };
  }
}
