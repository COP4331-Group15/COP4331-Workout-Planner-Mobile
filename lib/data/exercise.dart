import 'dart:ui';

class Exercise {
  String muscleGroup;
  String name;
  int sets;
  int repititions;
  int duration;
  int resistance;

  String id = "";
  Color icon_color = Color(0xFF000000);

  Exercise(this.muscleGroup, this.name, this.sets, this.repititions,
      this.duration, this.resistance);

  factory Exercise.fromJSON(Map json) {
    return new Exercise(json["MuscleGroup"], json["Name"], json["Sets"],
        json["Repititions"], json["Duration"], json["Resistance"]);
  }

  Map toJson() {
    return {
      "muscleGroup": this.muscleGroup,
      "name": this.name,
      "sets": this.sets,
      "repititions": this.repititions,
      "duration": this.duration,
      "resistance": this.resistance
    };
  }
}
