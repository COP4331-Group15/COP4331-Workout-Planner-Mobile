import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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
    Map parse = jsonDecode(response.body);
    return Split.fromJSON(parse);
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

  static Future<Exercise> getExerciseSpecific() async {
    User? user = FirebaseAuth.instance.currentUser;
    String _exerciseId = "";

    if (user == null) {
      print('Error: User not signed in');
      return Exercise("", "", -1, -1, -1, -1);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/exercise/${user.uid}/$_exerciseId"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Exercise.fromJSON(parse);
  }

  static Future<Workout> getWorkoutUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('Error: User not signed in');
      return Workout("", false, []);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http
        .get(Uri.parse("$_baseUrl/workout/${user.uid}/"), headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Workout.fromJSON(parse);
  }

  static Future<Workout> getWorkoutSpecific() async {
    User? user = FirebaseAuth.instance.currentUser;
    String _workoutId = "";

    if (user == null) {
      print('Error: User not signed in');
      return Workout("", false, []);
    }

    Map<String, String> header = await _getHeader();
    Response response = await http.get(
        Uri.parse("$_baseUrl/exercise/${user.uid}/$_workoutId"),
        headers: header);
    print(response.body);
    Map parse = jsonDecode(response.body);
    return Workout.fromJSON(parse);
  }
}
