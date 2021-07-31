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
    return response.body;
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

  static Future<String> postExercise(Map data, String ex_id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.post(
        Uri.parse("$_baseUrl/exercise/${user.uid}/${ex_id}/create"),
        headers: header,
        body: body);
    print(response.body);
    return response.body;
  }

  static Future<String> patchExercise(Map data, String ex_id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.patch(
        Uri.parse("$_baseUrl/exercise/${user.uid}/${ex_id}/update"),
        headers: header,
        body: body);
    print(response.body);
    return response.body;
  }

  static Future<String> deleteExercise(String ex_id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    Map<String, String> header = await _getHeader();
    Response response = await http.delete(
        Uri.parse("$_baseUrl/exercise/${user.uid}/${ex_id}/delete"),
        headers: header);
    print(response.body);
    return response.body;
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
    return response.body;
  }

  static Future<String> patchWorkout(Map data, String w_id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    var body = json.encode(data);
    Map<String, String> header = await _getHeader();
    Response response = await http.patch(
        Uri.parse("$_baseUrl/workout/${user.uid}/${w_id}/update"),
        headers: header,
        body: body);
    print(response.body);
    return response.body;
  }

  static Future<String> deleteWorkout(String w_id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Error: User not signed in');
      return "";
    }
    Map<String, String> header = await _getHeader();
    Response response = await http.patch(
        Uri.parse("$_baseUrl/workout/${user.uid}/${w_id}/delete"),
        headers: header);
    print(response.body);
    return response.body;
  }
}
