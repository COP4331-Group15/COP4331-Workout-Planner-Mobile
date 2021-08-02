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
      this.duration, this.resistance);

  factory Exercise.fromJSON(Map json) {
    return new Exercise(json["MuscleGroup"], json["Name"], json["Sets"],
        json["Repetitions"], json["Duration"], json["Resistance"]);
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
