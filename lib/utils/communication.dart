import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:large_project_app/data/calendar.dart';
import 'package:large_project_app/data/exercise.dart';
import 'package:large_project_app/data/split.dart';
import 'package:large_project_app/data/workout.dart';

class Communication {
  static final String _baseUrl =
      "https://workout-sprinter-api.herokuapp.com/api";

  static Future<Split> getSplit() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('Error: User not signed in');
      return Split(0, 0, 0, []);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http
        .get(Uri.parse("$_baseUrl/split/${user.uid}/"), headers: header);
    print(response.body);
    try {
      Map parse = jsonDecode(response.body);
      return Split.fromJSON(parse);
    } catch (e) {
      DateTime dt = new DateTime.now();
      Map data = {
        "startDate": dt.day,
        "startMonth": dt.month - 1,
        "startYear": dt.year,
        "workouts": [],
      };
      postSplit(data);
      return getSplit();
    }
  }

  static Future<String> postSplit(Map data) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.post(
        Uri.parse("$_baseUrl/split/${user.uid}/create"),
        headers: header,
        body: body);
    print(response.body);
    return jsonDecode(response.body)["data"]["name"];
  }

  static Future<String> patchSplit(Map data) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.patch(
        Uri.parse("$_baseUrl/split/${user.uid}/update"),
        headers: header,
        body: body);
    print(response.body);
    return response.body;
  }

  static Future<Map<String, String>> _getHeader() async {
    User? user = FirebaseAuth.instance.currentUser;
    String token;

    if (user == null) {
      print('Error: User not signed in');
      return {};
    }

    token = await user.getIdToken();

    return {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
  }

  static Future<Exercise> getExerciseUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('Error: User not signed in');
      return Exercise("", "", -1, -1, -1, -1);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http
        .get(Uri.parse("$_baseUrl/exercise/${user.uid}/"), headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Exercise.fromJSON(parse);
  }

  static Future<Exercise> getExerciseSpecific(String exerciseId) async {
    User? user = FirebaseAuth.instance.currentUser;
    String _exerciseId = "";

    if (user == null) {
      print('Error: User not signed in');
      return Exercise("", "", -1, -1, -1, -1);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/exercise/${user.uid}/$exerciseId"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Exercise.fromJSON(parse);
  }

  static Future<String> postExercise(Map data) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.post(
        Uri.parse("$_baseUrl/exercise/${user.uid}/create"),
        headers: header,
        body: body);
    print(response.body);
    return jsonDecode(response.body)["data"]["name"];
  }

  static Future<String> patchExercise(Map data, String exerciseId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.patch(
        Uri.parse("$_baseUrl/exercise/${user.uid}/$exerciseId/update"),
        headers: header,
        body: body);
    print(response.body);
    return response.body;
  }

  static Future<String> deleteExercise(String exerciseId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    Map<String, String> header = await _getHeader();
    Response response = await http.delete(
        Uri.parse("$_baseUrl/exercise/${user.uid}/$exerciseId/delete"),
        headers: header);
    print(response.body);
    return response.body;
  }

  static Future<Workout> getWorkoutUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('Error: User not signed in');
      return Workout(0, false, []);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http
        .get(Uri.parse("$_baseUrl/workout/${user.uid}/"), headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Workout.fromJSON(parse);
  }

  static Future<Workout> getWorkoutSpecific(String workoutId) async {
    User? user = FirebaseAuth.instance.currentUser;
    String _workoutId = "";

    if (user == null) {
      print('Error: User not signed in');
      return Workout(0, false, []);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/workout/${user.uid}/$workoutId"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Workout.fromJSON(parse);
  }

  static Future<String> postWorkout(Map data) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.post(
        Uri.parse("$_baseUrl/workout/${user.uid}/create"),
        headers: header,
        body: body);
    print(response.body);
    return jsonDecode(response.body)["data"]["name"];
  }

  static Future<String> patchWorkout(Map data, String workoutId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.patch(
        Uri.parse("$_baseUrl/workout/${user.uid}/$workoutId/update"),
        headers: header,
        body: body);
    print(response.body);
    return response.body;
  }

  static Future<Calendar> getCalendar(int year, int month) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('Error: User not signed in');
      return Calendar([]);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/calendar/${user.uid}/$year/$month"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Calendar.fromJSON(parse);
  }

  static Future<List<Exercise>> getExercisesPerDate(
      int year, int month, int day) async {
    User? user = FirebaseAuth.instance.currentUser;
    List<Exercise> exercises = [];
    if (user == null) {
      print('Error: User not signed in');
      return exercises;
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/calendar/${user.uid}/$year/$month/$day/exercises"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    for (Map element in parse["exercises"]) {
      exercises.add(Exercise.fromJSON(element));
    }

    return exercises;
  }

  static Future<List<Exercise>> getExercisesPerWorkout(String workoutId) async {
    User? user = FirebaseAuth.instance.currentUser;
    List<Exercise> exercises = [];
    if (user == null) {
      print('Error: User not signed in');
      return exercises;
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/workout/${user.uid}/$workoutId/exercises"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    for (Map element in parse["exercises"]) {
      exercises.add(Exercise.fromJSON(element));
    }

    return exercises;
  }

  static Future<String> deleteWorkout(String workoutId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    Map<String, String> header = await _getHeader();
    Response response = await http.delete(
        Uri.parse("$_baseUrl/workout/${user.uid}/$workoutId/delete"),
        headers: header);
    print(response.body);
    return response.body;
  }
}
