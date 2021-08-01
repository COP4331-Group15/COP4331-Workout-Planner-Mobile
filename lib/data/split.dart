class Split {
  int startDate;
  int startMonth;
  int startYear;

  List<String> workouts;

  Split(this.startDate, this.startMonth, this.startYear, this.workouts);

  factory Split.fromJSON(Map json) {
    if (json["Workouts"] == null) {
      return new Split(
          json["StartDate"], json["StartMonth"], json["StartYear"], []);
    } else {
      return new Split(json["StartDate"], json["StartMonth"], json["StartYear"],
          json["Workouts"].cast<String>());
    }
  }

  Map toJson() {
    return {
      "startDate": this.startDate,
      "startMonth": this.startMonth,
      "startYear": this.startDate,
      "workouts": this.workouts,
    };
  }
}
